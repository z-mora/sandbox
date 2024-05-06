output "id" {
  value       = azurerm_private_dns_resolver.this.id
  description = "The ID of the private DNS resolver that was deployed."
}

output "inbound_endpoint_ip" {
  description = "The private IP of the inbound endpoint"
  value       = azurerm_private_dns_resolver_inbound_endpoint.this.ip_configurations[0].private_ip_address
}

output "outbound_endpoint_id" {
  description = "The ID of the outbound endpoint"
  value       = azurerm_private_dns_resolver_outbound_endpoint.this.id
}

output "location" {
  description = "The region of the private DNS resolver"
  value       = var.location
}
