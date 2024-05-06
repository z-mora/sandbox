resource "aws_ec2_transit_gateway" "this" {
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments ? "enable" : "disable"
  default_route_table_association = var.default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.default_route_table_propagation ? "enable" : "disable"
  description                     = var.description
  dns_support                     = var.dns_support ? "enable" : "disable"
  transit_gateway_cidr_blocks     = var.cidr_blocks
  vpn_ecmp_support                = var.vpn_ecmp_support ? "enable" : "disable"

  tags = merge({ Name = var.name }, local.tags)
}

resource "aws_ram_resource_share" "this" {
  count = length(var.share_to_principals) > 0 ? 1 : 0

  allow_external_principals = true
  name                      = "ram-${var.name}"
  tags                      = local.tags
}

resource "aws_ram_resource_association" "this" {
  count = length(var.share_to_principals) > 0 ? 1 : 0

  resource_arn       = aws_ec2_transit_gateway.this.arn
  resource_share_arn = aws_ram_resource_share.this[0].arn
}

resource "aws_ram_principal_association" "this" {
  for_each = var.share_to_principals

  principal          = each.value
  resource_share_arn = aws_ram_resource_share.this[0].arn
}
