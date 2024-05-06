resource "azurerm_availability_set" "availability_set" {
  location                     = var.location
  managed                      = var.managed
  name                         = var.avset_name
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  resource_group_name          = var.resource_group_name
  tags                         = var.required_tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  eventhub_authorization_rule_id = var.monitor_diagnostic_destinations.eventhubs[var.location].authorization_rule_id
  eventhub_name                  = var.monitor_diagnostic_destinations.eventhubs[var.location].eventhub_name
  log_analytics_workspace_id     = var.monitor_diagnostic_destinations.log_analytics_workspace_id
  name                           = "diag-${var.avset_name}-activity-logs"
  target_resource_id             = azurerm_availability_set.availability_set.id
  ##log_analytics_destination_type = var.diag_destination_type "unsure if we use this"

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
      enabled  = true # Create other Modules if you don't want them all on, by default
    }
  }
}
