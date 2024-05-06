log_analytics_workspaces = {
  "logworkspace-activity-logs-prod-01" = {
    daily_quota_gb             = -1
    internet_ingestion_enabled = true
    internet_query_enabled     = true
    location                   = "usgovvirginia"
    resource_group_name        = "rg-logging-prod-01"
    retention_in_days          = 30
    sku                        = "PerGB2018"
  }
}
