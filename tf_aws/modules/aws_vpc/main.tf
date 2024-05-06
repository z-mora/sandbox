resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  tags = merge(local.tags, { Name = var.vpc_name })
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
  count = var.dhcp_options == null ? 0 : 1

  domain_name = var.dhcp_options.domain_name
  domain_name_servers = (
    var.dhcp_options.domain_name_servers == null
    ? ["AmazonProvidedDNS"] : var.dhcp_options.domain_name_servers
  )

  tags = merge(local.tags, { "Name" = "${var.vpc_name}-DHCPOptions" })
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  # Ensure default option set is attached if we didn't specify a custom option set
  dhcp_options_id = (
    var.dhcp_options == null ?
    data.aws_vpc_dhcp_options.default[0].id :
    aws_vpc_dhcp_options.dns_resolver[0].id
  )
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route53_resolver_config" "main" {
  # Create 1 config if we're using resolver rules
  # Use try() in case var.dhcp_options is null
  count = try(length(var.dhcp_options.resolver_rule_ids) == 0 ? 0 : 1, 0)

  autodefined_reverse_flag = "DISABLE"
  resource_id              = aws_vpc.vpc.id
}

resource "aws_route53_resolver_rule_association" "forwarder" {
  # Associate each resolver rule, if any were specified
  # Use try() in case var.dhcp_options is null
  for_each = try(var.dhcp_options.resolver_rule_ids, toset([]))

  resolver_rule_id = each.value
  vpc_id           = aws_vpc.vpc.id
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.vpc.id

  tags = merge(local.tags, { "Name" = "${var.vpc_name}-${each.key}" })

  # Make sure the selected AZ name is in the list of allowed zones
  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.allowed.names, each.value.availability_zone)
      error_message = "You must not use an excluded zone"
    }
  }
}

resource "aws_ec2_subnet_cidr_reservation" "main" {
  for_each = var.private_subnets
  
  description      = var.subnet_res_cidr_desc
  cidr_block       = var.subnet_res_cidr_block
  reservation_type = "prefix"
  subnet_id        = aws_subnet.private[each.key].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway_vpc_attachment" {
  vpc_id             = aws_vpc.vpc.id
  subnet_ids         = local.private_subnet_id_per_az
  transit_gateway_id = var.transit_gateway_id
  tags               = local.tags
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = var.transit_gateway_id
  }
  route {
    cidr_block         = "172.16.0.0/12"
    transit_gateway_id = var.transit_gateway_id
  }
  tags = merge(local.tags, { "Name" = "${var.vpc_name}-RT" })
}

resource "aws_route_table_association" "default" {
  for_each = var.private_subnets

  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.private[each.key].id
}

resource "aws_vpc_endpoint" "s3" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "*"
        Effect    = "Allow"
        Resource  = "*"
        Principal = "*"
      },
    ]
  })
  route_table_ids = [aws_route_table.default.id]
  service_name    = "com.amazonaws.${var.region}.s3"
  vpc_id          = aws_vpc.vpc.id
  tags            = local.tags
}
