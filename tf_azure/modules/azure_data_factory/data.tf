data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_data_factory.this.id
}
