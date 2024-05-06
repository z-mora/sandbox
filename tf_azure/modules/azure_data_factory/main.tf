resource "azurerm_data_factory" "this" {
  location               = var.location
  name                   = var.name
  public_network_enabled = var.public_network_enabled
  resource_group_name    = var.resource_group_name
  tags                   = var.required_tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  eventhub_authorization_rule_id = var.monitor_diagnostic_destinations.eventhubs[var.location].authorization_rule_id
  eventhub_name                  = var.monitor_diagnostic_destinations.eventhubs[var.location].eventhub_name
  log_analytics_workspace_id     = var.monitor_diagnostic_destinations.log_analytics_workspace_id
  name                           = "diag-${var.name}-activity-logs"
  target_resource_id             = azurerm_data_factory.this.id

  dynamic "enabled_log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.this.log_category_types)
    content {
      category = enabled_log.key
    }
  }

  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.this.metrics)
    content {
      category = metric.key
      enabled  = true
    }
  }
}
