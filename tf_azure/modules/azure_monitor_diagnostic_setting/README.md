<!-- BEGIN_TF_DOCS -->
# azure_monitor_diagnostic_setting

This module creates diagnostic settings in Azure Monitor. It sends activity logs for the
subscription to an event hub and log analytics workspace in the logging subscription.

## Additional Info

* [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings?tabs=portal)
* [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activitylogs_eventhubs"></a> [activitylogs\_eventhubs](#input\_activitylogs\_eventhubs) | Object map of Monitor Diagnostic Settings for Activity Logs to Eventhub. | <pre>map(object({<br>    eventhub_name                     = string<br>    eventhubspace_name                = string<br>    eventhubspace_resource_group_name = string<br>    eventhubspace_subscription_id     = string<br>  }))</pre> | `{}` | no |
| <a name="input_activitylogs_log_analytics"></a> [activitylogs\_log\_analytics](#input\_activitylogs\_log\_analytics) | Object map of Monitor Diagnostic Settings for Activity Logs to Log Analytics. | <pre>map(object({<br>    log_analytics_resource_group_name = string<br>    log_analytics_subscription_id     = string<br>    log_analytics_workspace_id        = string<br>  }))</pre> | `{}` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID for the Azure subscription | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting_event_hub_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting_log_analytics_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Examples

```hcl
# Example 1
monitor_diagnostic_settings = {
  "diag-subscription-activity-logs-01" = {
    activitylogs_eventhubs = {
      "diag-subscription-activity-logs-eventhub" = {
        eventhub_name                     = "ehub-activity-logs-prod-01"
        eventhubspace_name                = "ehubspace-logging-prod-01"
        eventhubspace_resource_group_name = "rg-logging-prod-01"
        eventhubspace_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
      }
    }
    activitylogs_log_analytics = {
      "diag-subscription-activity-logs-log-analytics" = {
        log_analytics_resource_group_name = "rg-logging-prod-01"
        log_analytics_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
        log_analytics_workspace_id        = "logworkspace-activity-logs-prod-01"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->