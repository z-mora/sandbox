<!-- BEGIN_TF_DOCS -->
# azure_management_group_association

This module allows you to associate a management group to a subscription.

## Additional Info

* [What are Azure management groups?](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)
* [azurerm_management_group_subscription_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | management group name, used for management group subscription association | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | subscription ID, used for management group subscription association | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_management_group.management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Examples

```hcl
# N/A
```
<!-- END_TF_DOCS -->