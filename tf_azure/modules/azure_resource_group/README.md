<!-- BEGIN_TF_DOCS -->
# azure_resource_group

This module allows you to create a resource group.

## Additional Info

* [What is a resource group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)
* [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | resource group name |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Examples

```hcl
# Example 1
resource_groups = {
  "rg-infraops-eastus2-prod-01" = "eastus2"
  "rg-infraops-westus2-prod-01" = "westus2"
}
```
<!-- END_TF_DOCS -->