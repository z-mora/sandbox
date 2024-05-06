data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_availability_set.availability_set.id
}