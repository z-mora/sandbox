resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting_event_hub_subscription" {
  for_each = var.activitylogs_eventhubs

  eventhub_authorization_rule_id = "/subscriptions/${each.value.eventhubspace_subscription_id}/resourceGroups/${each.value.eventhubspace_resource_group_name}/providers/Microsoft.EventHub/namespaces/${each.value.eventhubspace_name}/authorizationRules/RootManageSharedAccessKey"
  eventhub_name                  = each.value.eventhub_name
  name                           = each.key
  target_resource_id             = "/subscriptions/${var.subscription_id}"

  dynamic "enabled_log" {
    for_each = local.log_categories
    content {
      category = enabled_log.value
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting_log_analytics_subscription" {
  for_each = var.activitylogs_log_analytics

  log_analytics_workspace_id = "/subscriptions/${each.value.log_analytics_subscription_id}/resourceGroups/${each.value.log_analytics_resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${each.value.log_analytics_workspace_id}"
  name                       = each.key
  target_resource_id         = "/subscriptions/${var.subscription_id}"

  dynamic "enabled_log" {
    for_each = local.log_categories
    content {
      category = enabled_log.value
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
