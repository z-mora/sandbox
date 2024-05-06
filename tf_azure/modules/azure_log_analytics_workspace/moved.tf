moved {
  from = azurerm_log_analytics_workspace.log_analytics_workspace["logworkspace-activity-logs-prod-01"]
  to   = azurerm_log_analytics_workspace.this
}
