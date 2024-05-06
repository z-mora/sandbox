<!-- BEGIN_TF_DOCS -->
# azure_role

This module allows you to build a custom role with permissions (Actions, NotActions,
DataActions, and NotDataActions). We typically use this to provide the BU owners with
limited administrator access to their subscription. At this time, the role and users are
manually assigned to the subscription in the UI.

## Additional Info

* [What is Azure role-based access control (Azure RBAC)?](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
* [azurerm_role_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition.html)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | list of allowed actions | `list(string)` | n/a | yes |
| <a name="input_data_actions"></a> [data\_actions](#input\_data\_actions) | list of allowed data actions | `list(string)` | n/a | yes |
| <a name="input_not_actions"></a> [not\_actions](#input\_not\_actions) | list of disallowed actions | `list(string)` | n/a | yes |
| <a name="input_not_data_actions"></a> [not\_data\_actions](#input\_not\_data\_actions) | list of disallowed data actions | `list(string)` | n/a | yes |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | description of the role | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the role | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope at which the Role Definition applies to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Terraform-specific ID of the role. THe format is `{roleDefinitionId}|{scope}`.<br>This is only used by the `azure_role_assignment` module to create an implicit<br>dependency. |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

## Examples

```hcl
# Example 1 - RBAC role for BU subscription owners
azure_roles = {
  "roles-01" = {
    role_definition = {
      "role-subscription-ad-tips-dev-01-admin" = {
        actions          = ["*"]
        data_actions     = []
        not_actions = [
          "Microsoft.Authorization/elevateAccess/Action",
          "Microsoft.Authorization/*/Delete",
          "Microsoft.Authorization/*/Write",
          "Microsoft.Blueprint/blueprintAssignments/delete",
          "Microsoft.Blueprint/blueprintAssignments/write",
          "Microsoft.Compute/galleries/share/action",
          "Microsoft.Insights/DiagnosticSettings/Delete",
          "Microsoft.Insights/DiagnosticSettings/Write",
          "Microsoft.Network/virtualHubs/*",
          "Microsoft.Network/VirtualNetworks/Delete",
          "Microsoft.Network/virtualNetworks/subnets/Delete",
          "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/Delete",
          "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/Write",
          "Microsoft.Network/VirtualNetworks/Write",
          "Microsoft.Network/virtualRouters/Delete",
          "Microsoft.Network/virtualRouters/peerings/Delete",
          "Microsoft.Network/virtualRouters/peerings/Write",
          "Microsoft.Network/virtualRouters/Write",
          "Microsoft.Network/virtualWans/*"
        ]
        not_data_actions = []
        role_description = "Subscription role to allow for all actions with some network exceptions."
      }
    }
  }
}
```
<!-- END_TF_DOCS -->