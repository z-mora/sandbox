<!-- BEGIN_TF_DOCS -->
# azure_storage

This module allows you to create a basic data factory.

Most functionality for this resource is not supported yet.

## Additional Info

* [azurerm_data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location where the resource will be created | `string` | n/a | yes |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource that will be created. Must be globally unique | `string` | n/a | yes |
| <a name="input_public_network_enabled"></a> [public\_network\_enabled](#input\_public\_network\_enabled) | Is the Data Factory visible to the public network? | `bool` | `false` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the data factory |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Examples

```hcl
# Example 1
data_factories = {
  adf-parsons-centralized-portal = {
    location = "usgovvirginia"
    resource_group_name = "rg-infraops-prod-01"
  }
}
```
<!-- END_TF_DOCS -->