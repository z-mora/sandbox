output "id" {
  value       = aws_customer_gateway.this.id
  description = "The ID of the customer gateway"
}

output "vpn_ids" {
  value       = { for vpn_key, vpn in aws_vpn_connection.this : vpn_key => vpn.id }
  description = "Map of site-to-site VPN connection keys and IDs"
}
