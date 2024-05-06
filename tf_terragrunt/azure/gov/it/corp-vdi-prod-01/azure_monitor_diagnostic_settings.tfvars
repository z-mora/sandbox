monitor_diagnostic_settings = {
  "diag-subscription-activity-logs-01" = {
    activitylogs_eventhubs = {
      "diag-subscription-activity-logs-eventhub" = {
        eventhub_name                     = "ehub-activity-logs-prod-01"
        eventhubspace_name                = "ehubspace-logging-prod-01"
        eventhubspace_resource_group_name = "rg-logging-prod-01"
        eventhubspace_subscription_id     = "19b154c8-1d33-40a6-8454-f48d7fc08db8"
      }
    }
    activitylogs_log_analytics = {
      "diag-subscription-activity-logs-log-analytics" = {
        log_analytics_resource_group_name = "rg-logging-prod-01"
        log_analytics_subscription_id     = "19b154c8-1d33-40a6-8454-f48d7fc08db8"
        log_analytics_workspace_id        = "logworkspace-activity-logs-prod-01"
      }
    }
  }
}
