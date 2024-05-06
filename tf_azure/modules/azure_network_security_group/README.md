<!-- BEGIN_TF_DOCS -->
# azure_network_security_group

This module creates a network security group with inbound/outbound rules. It also
enables flowlogs for the NSG and sends them to a storage account in the logging
subscription. The NSG rules are created as a separate resource as opposed to inline.
When we hand the subscription over to users they may make adjustments to the NSG rules,
which will show up as inline rules. This is why we ignore changes to the `security_rule`
attribute on the NSG to avoid drift.

## Additional Info

* [Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
* [Flow logging for network security groups](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-nsg-flow-logging-overview)
* [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group.html)
* [azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule)
* [azurerm_network_watcher_flow_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_flowlogs_enable"></a> [flowlogs\_enable](#input\_flowlogs\_enable) | Boolean flag to enable NSG Flowlogs | `bool` | `"false"` | no |
| <a name="input_flowlogs_resource_group_name"></a> [flowlogs\_resource\_group\_name](#input\_flowlogs\_resource\_group\_name) | Resource Group name destination for NSG Flowlogs | `string` | n/a | yes |
| <a name="input_flowlogs_retention_days"></a> [flowlogs\_retention\_days](#input\_flowlogs\_retention\_days) | Number of days to retain FlowLog records | `number` | `7` | no |
| <a name="input_flowlogs_storageaccount_id"></a> [flowlogs\_storageaccount\_id](#input\_flowlogs\_storageaccount\_id) | Storage account id destination for NSG Flowlogs | `string` | n/a | yes |
| <a name="input_flowlogs_subscription_id"></a> [flowlogs\_subscription\_id](#input\_flowlogs\_subscription\_id) | Subscription id destination for NSG Flowlogs | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"eastus2"` | no |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Network security group name | `string` | n/a | yes |
| <a name="input_network_watcher_name"></a> [network\_watcher\_name](#input\_network\_watcher\_name) | Name of the Network Watcher | `string` | n/a | yes |
| <a name="input_network_watcher_resource_group"></a> [network\_watcher\_resource\_group](#input\_network\_watcher\_resource\_group) | Resource Group name of the network watcher RG | `string` | `"NetworkWatcherRG"` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Object map of network security rules | <pre>map(object({<br>    access                     = string<br>    description                = string<br>    destination_address_prefix = string<br>    destination_port_range     = string<br>    direction                  = string<br>    priority                   = number<br>    protocol                   = string<br>    source_address_prefix      = string<br>    source_port_range          = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the network security group |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_watcher_flow_log.network_security_groups_flowlogs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Examples

```hcl
# Example 1
network_security_groups = {
  "nsg-ad-tips-dev-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "eastus2"
    resource_group_name          = "rg-ad-tips-dev-01"
    rules = {
      "allow-10.0.0.0" = {
        access                     = "Allow"
        description                = "Allow-10.0.0.0"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "10.0.0.0/8"
        source_port_range          = "*"
      }
      "allow-172.16.0.0" = {
        access                     = "Allow"
        description                = "Allow-172.16.0.0"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 101
        protocol                   = "*"
        source_address_prefix      = "172.16.0.0/12"
        source_port_range          = "*"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->