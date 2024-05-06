data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_network_security_group.this.id
}