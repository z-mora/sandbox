<!-- BEGIN_TF_DOCS -->
# azure_managed_identity

This module allows you to create a user-assigned managed identity.

## Additional Info

* [What are managed identities for Azure resources?](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview)
* [azurerm_user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the User Assigned Identity should exist. Changing this forces<br>a new User Assigned Identity to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the managed identity. Changing this forces a new User Assigned Identity<br>to be created. | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group within which this User Assigned Identity should exist.<br>Changing this forces a new User Assigned Identity to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The ID of the app associated with the Identity. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the user-assigned managed identity. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The ID of the service principal associated with the identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The ID of the tenant which the identity belongs to. |

## Resources

| Name | Type |
|------|------|
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Examples

```hcl
# Example 1
managed_identities = {
  mike-test = {
    location = "eastus2"
    resource_group_name = "rg-infraops-dev-01"
  }
}
```
<!-- END_TF_DOCS -->