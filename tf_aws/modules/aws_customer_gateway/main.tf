resource "aws_customer_gateway" "this" {
  bgp_asn    = var.bgp_asn
  ip_address = var.ip_address
  type       = "ipsec.1"

  tags = merge(local.tags, { Name = var.name })
}

resource "aws_vpn_connection" "this" {
  for_each = var.vpn_connections

  customer_gateway_id = aws_customer_gateway.this.id
  transit_gateway_id  = each.value.transit_gateway_id
  type                = "ipsec.1"

  tags = merge(local.tags, { Name = each.key })
}
