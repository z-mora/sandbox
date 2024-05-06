resource "azurerm_network_security_group" "this" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.required_tags

  lifecycle {
    # Ignore inline rule changes made by users in the UI
    ignore_changes = [security_rule]
  }
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.rules

  access                      = each.value.access # Options are Allow, Deny
  description                 = each.value.description
  destination_address_prefix  = each.value.destination_address_prefix
  destination_port_range      = each.value.destination_port_range
  direction                   = each.value.direction # Options are Inbound, Outbound
  name                        = each.key
  network_security_group_name = azurerm_network_security_group.this.name
  priority                    = each.value.priority # Options are 100 - 4096
  protocol                    = each.value.protocol # Options are Tcp, Udp, Icmp, Esp, Ah
  resource_group_name         = var.resource_group_name
  source_address_prefix       = each.value.source_address_prefix
  source_port_range           = each.value.source_port_range
}

resource "azurerm_network_watcher_flow_log" "network_security_groups_flowlogs" {
  enabled                   = var.flowlogs_enable
  name                      = "flowlog-${var.name}"
  network_security_group_id = azurerm_network_security_group.this.id
  network_watcher_name      = var.network_watcher_name
  resource_group_name       = var.network_watcher_resource_group
  storage_account_id        = "/subscriptions/${var.flowlogs_subscription_id}/resourceGroups/${var.flowlogs_resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.flowlogs_storageaccount_id}"
  tags                      = var.required_tags
  version                   = 2

  retention_policy {
    days    = var.flowlogs_retention_days
    enabled = var.flowlogs_enable
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  eventhub_authorization_rule_id = var.monitor_diagnostic_destinations.eventhubs[var.location].authorization_rule_id
  eventhub_name                  = var.monitor_diagnostic_destinations.eventhubs[var.location].eventhub_name
  log_analytics_workspace_id     = var.monitor_diagnostic_destinations.log_analytics_workspace_id
  name                           = "diag-${var.name}-activity-logs"
  target_resource_id             = azurerm_network_security_group.this.id
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
