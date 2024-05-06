data "aws_ec2_transit_gateway_vpc_attachment" "looking_up_tgw" {
  count = length(var.tgw_vpc_attachment_ids) > 0 ? 1 : 0

  id = values(var.tgw_vpc_attachment_ids)[0]
}

data "aws_ec2_transit_gateway_attachments" "vpn" {
  filter {
    name   = "resource-type"
    values = ["vpn"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ec2_transit_gateway_attachment" "first_vpn" {
  count = length(var.tgw_vpc_attachment_ids) > 0 ? 1 : 0

  transit_gateway_attachment_id = data.aws_ec2_transit_gateway_attachments.vpn.ids[0]
}
