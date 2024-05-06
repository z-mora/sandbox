output "default_association_route_table" {
  value       = aws_ec2_transit_gateway_route_table.this.default_association_route_table
  description = "If this is the default association route table for the TGW"
}

output "default_propagation_route_table" {
  value       = aws_ec2_transit_gateway_route_table.this.default_propagation_route_table
  description = "If this is the default propagation route table for the TGW"
}

output "id" {
  value       = aws_ec2_transit_gateway_route_table.this.id
  description = "The ID of the transit gateway route table"
}
