<!-- BEGIN_TF_DOCS -->
# azure_availability_set

This module will create a new availability set.

## Additional Info

* [Availability sets overview](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)
* [azurerm_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_avset_name"></a> [avset\_name](#input\_avset\_name) | Availability Set name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Name of the Azure region | `string` | n/a | yes |
| <a name="input_managed"></a> [managed](#input\_managed) | Does the Availability Set use managed disks | `bool` | `true` | no |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | Number of fault domains that are used | `string` | `"3"` | no |
| <a name="input_platform_update_domain_count"></a> [platform\_update\_domain\_count](#input\_platform\_update\_domain\_count) | Number of update domains that are used | `string` | `"5"` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "SERVER")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_set_id"></a> [availability\_set\_id](#output\_availability\_set\_id) | ID of the Azure Availability Set |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Examples

```hcl
# Example 1
availability_sets = {
  "test-availability-set-1" = {
    location = "eastus2"
    resource_group_name = "rg-infraops-prod-01"
  }
}
```
<!-- END_TF_DOCS -->