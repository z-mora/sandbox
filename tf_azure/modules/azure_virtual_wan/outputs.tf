output "virtual_wan" {
  value       = azurerm_virtual_wan.this
  description = "All of the attributes for the VWAN that was deployed"
}

output "virtual_hub" {
  value       = azurerm_virtual_hub.this
  description = "A map of all of the virtual hubs that were deployed"
}
