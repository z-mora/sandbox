output "location" {
  description = "The location of the eventhub namespace"
  value       = var.location
}

output "first_eventhub_name" {
  description = "The name of the first eventhub"
  value       = azurerm_eventhub.eventhub[one(keys(azurerm_eventhub.eventhub))].name
}

output "name" {
  description = "The name of the eventhub namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespaces.name
}
