resource "azurerm_log_analytics_workspace" "this" {
  daily_quota_gb             = var.daily_quota_gb
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
  location                   = var.location
  name                       = var.name
  resource_group_name        = var.resource_group_name
  retention_in_days          = var.retention_in_days
  sku                        = var.sku
  tags                       = var.required_tags
}
