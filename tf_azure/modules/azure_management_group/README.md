<!-- BEGIN_TF_DOCS -->
# azure_management_group

This module allows you to deploy a management group. Azure only allows you to nest
management groups 6 levels deep.

## Additional Info

* [What are Azure management groups?](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)
* [azurerm_management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_child_groups"></a> [child\_groups](#input\_child\_groups) | Nested child management groups to create under the current group. The type is<br>  ambiguous because these child groups can be nested up to 5 levels deep. The map key<br>  should be the child management group name. | `map(any)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the parent management group | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.level_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_5](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_6](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Examples

```hcl
# Example 1 - Flat groups
management_groups = {
  "mg-ci-prod-01" = {}
  "mg-fed-prod-01" = {}
  "mg-infra-prod-01" = {}
  "mg-network-prod-01" = {}
  "mg-security-prod-01" = {}
}

# Example 2 - Nested management groups
management_groups = {
  "mg-ci-prod-01" = {
    "mg-ci-prod-01-nested-group-01" = {}
  }
}
```
<!-- END_TF_DOCS -->