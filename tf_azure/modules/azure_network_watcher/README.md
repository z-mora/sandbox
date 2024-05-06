<!-- BEGIN_TF_DOCS -->
# azure_network_watcher

This module creates a Network Watcher resource group and 1 Network Watcher
resource for each region we deploy network resources in.

This will be useast2 and uswest2 for Commercial, and usgovvirginia for Government.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | Bool determining whether the environment is Government or Commercial | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name_by_location"></a> [name\_by\_location](#output\_name\_by\_location) | map containing the key/value pairs of each network watcher's location/name |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | name of the resource group the network watcher(s) will reside in |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_watcher.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_resource_group.networkwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Examples

```hcl
deploy_network_watcher = true
```
<!-- END_TF_DOCS -->