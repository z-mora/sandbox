<!-- BEGIN_TF_DOCS -->
# azure_log_analytics_workspace

This module allows you to deploy a log analytics workspace.

## Additional Info

* [Log Analytics workspace overview](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)
* [azurerm_log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_daily_quota_gb"></a> [daily\_quota\_gb](#input\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted. | `number` | `-1` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resource should be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the log analytics workspace to create | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "STORAGE")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group that the resources should be created in | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The workspace data retention in days. | `number` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Specifies the SKU of the Log Analytics Workspace. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the log analytics workspace that was created |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Examples

```hcl
# Example 1
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
```
<!-- END_TF_DOCS -->