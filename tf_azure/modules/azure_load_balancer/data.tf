data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_lb.load_balancers.id
}