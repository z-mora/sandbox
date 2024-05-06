output "id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "subnet_ids" {
  value       = { for subnet_key, subnet in aws_subnet.private : subnet_key => subnet.id }
  description = "Map of subnet keys and IDs"
}

output "tgw_vpc_attachment_id" {
  value       = aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment.id
  description = "The ID of the VPC's transit gateway attachment"
}
