resource "aws_ec2_transit_gateway_route_table" "this" {
  tags               = merge(local.tags, { Name = var.name })
  transit_gateway_id = local.tgw_id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_to_project_rt" {
  for_each = var.tgw_vpc_attachment_ids

  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_to_project_rt" {
  for_each = var.tgw_vpc_attachment_ids

  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpn_to_project_rt" {
  for_each = (
    length(var.transit_gateway_id) > 0 ? toset([]) :
    toset(data.aws_ec2_transit_gateway_attachments.vpn.ids)
  )

  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_to_central_rt" {
  for_each = var.tgw_vpc_attachment_ids

  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = local.central_route_table_id
}

resource "aws_ec2_transit_gateway_route" "blackhole" {
  for_each = length(var.transit_gateway_id) > 0 ? toset([]) : coalesce(
    var.override_blackhole_cidrs, local.blackhole_cidrs[var.organization_id]
  )

  blackhole                      = true
  destination_cidr_block         = each.value
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}
