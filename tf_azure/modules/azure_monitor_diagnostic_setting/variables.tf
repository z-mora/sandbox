variable "activitylogs_eventhubs" {
  type = map(object({
    eventhub_name                     = string
    eventhubspace_name                = string
    eventhubspace_resource_group_name = string
    eventhubspace_subscription_id     = string
  }))
  description = "Object map of Monitor Diagnostic Settings for Activity Logs to Eventhub."
  default     = {}
}

variable "activitylogs_log_analytics" {
  type = map(object({
    log_analytics_resource_group_name = string
    log_analytics_subscription_id     = string
    log_analytics_workspace_id        = string
  }))
  description = "Object map of Monitor Diagnostic Settings for Activity Logs to Log Analytics."
  default     = {}
}

variable "subscription_id" {
  type        = string
  description = "ID for the Azure subscription"
}
