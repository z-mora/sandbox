locals {
  blackhole_cidrs = {
    # FED GovCloud
    o-g2rv9h4diz = toset(["10.186.0.0/16", "10.187.0.0/16"])
    # FED Commercial
    o-ij0mvoif2w = toset(["10.188.0.0/16", "10.189.0.0/16"])
    # CI/INF Commercial
    o-x0augfafh3 = toset(["10.190.0.0/16", "10.191.0.0/16"])
  }
  central_route_table_id = (length(var.tgw_vpc_attachment_ids) > 0 ?
    data.aws_ec2_transit_gateway_attachment.first_vpn[0].association_transit_gateway_route_table_id
    : null
  )
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
  tgw_id = try(
    data.aws_ec2_transit_gateway_vpc_attachment.looking_up_tgw[0].transit_gateway_id,
    values(var.transit_gateway_id)[0]
  )
}
