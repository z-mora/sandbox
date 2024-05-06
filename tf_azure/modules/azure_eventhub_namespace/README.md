<!-- BEGIN_TF_DOCS -->
# azure_eventhub_namespace

This module allows you to build and configure an Azure Eventhub Namespace and Eventhubs
within the Namespace.

## Additional Info

* [Features and terminology in Azure Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-features)
* [azurerm_eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace)
* [azurerm_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub.html)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_inflate_enabled"></a> [auto\_inflate\_enabled](#input\_auto\_inflate\_enabled) | Boolean flag to specify whether the throughput units of a Standard SKU namespace can auto-inflate | `bool` | `false` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | Specifies the throughput units for a Standard SKU namespace.  Default is 2. | `number` | `"2"` | no |
| <a name="input_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#input\_eventhub\_namespace\_name) | Eventhub Namespace name | `string` | n/a | yes |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | Object map of Eventhubs | <pre>map(object({<br>    message_retention = number<br>    partition_count   = number<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"eastus2"` | no |
| <a name="input_maximum_throughput_units"></a> [maximum\_throughput\_units](#input\_maximum\_throughput\_units) | Maximum throughput units when auto-inflate is enabled.  Valid values are 1-20 | `number` | `"10"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow/Disallow public network access to the Storage Account | `bool` | `false` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "STORAGE")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Tier of Eventhub Namespace.  Valid options are Basic, Standard and Premium | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_first_eventhub_name"></a> [first\_eventhub\_name](#output\_first\_eventhub\_name) | The name of the first eventhub |
| <a name="output_location"></a> [location](#output\_location) | The location of the eventhub namespace |
| <a name="output_name"></a> [name](#output\_name) | The name of the eventhub namespace |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_namespace.eventhub_namespaces](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |

## Examples

```hcl
# Example 1 -
eventhub_namespaces = {
  "ehubspace-logging-prod-01" = {
    auto_inflate_enabled     = false
    capacity                 = 2
    eventhubs = {
      "ehub-activity-logs-prod-01" = {
        message_retention = 7
        partition_count   = 2
      }
    }
    location                 = "eastus2"
    maximum_throughput_units = 10
    resource_group_name      = "rg-logging-prod-01"
    sku                      = "Standard"
  }
}
```
<!-- END_TF_DOCS -->