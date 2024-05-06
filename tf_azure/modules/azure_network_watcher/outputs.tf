output "resource_group_name" {
  value       = azurerm_resource_group.networkwatcher.name
  description = "name of the resource group the network watcher(s) will reside in"
}

output "name_by_location" {
  value       = { for k, v in azurerm_network_watcher.this : v.location => v.name }
  description = "map containing the key/value pairs of each network watcher's location/name"
}
