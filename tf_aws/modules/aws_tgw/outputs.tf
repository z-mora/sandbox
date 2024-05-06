output "id" {
  value       = aws_ec2_transit_gateway.this.id
  description = "The ID of the transit gateway"
}

output "resource_share_arn" {
  value       = try(aws_ram_resource_share.this[0].id, "N/A")
  description = "The ARN of the resource share"
}
