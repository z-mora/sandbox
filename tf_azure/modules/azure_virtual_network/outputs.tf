output "id" {
  value       = azurerm_virtual_network.this.id
  description = "The ID of the virtual network that was deployed"
}

output "private_subnets" {
  value       = azurerm_subnet.private
  description = "A map of all of the private subnets that were deployed"
}
