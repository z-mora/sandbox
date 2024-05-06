<!-- BEGIN_TF_DOCS -->
# azure_role_assignment

This module allows you to assign users, groups, managed identities, and/or app
registrations (technically the app registration's service principal) to a built-in
or custom role at either the management group, resource group, or subscription level.
The ID of a scope can also be provided.

## Additional Info

* [azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)
* [Understand Azure role assignments](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_display_names"></a> [group\_display\_names](#input\_group\_display\_names) | The display name of groups to assign to the role | `set(string)` | `[]` | no |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | The ID of managed identities to assign to the role. The key is the key of the managed<br>identity and the value is the ID. | `map(string)` | `{}` | no |
| <a name="input_role"></a> [role](#input\_role) | The role that will be assigned. `name` is the name of a built-in or custom role.<br>`id` is only here so an implicity dependency can be created with the `azure_role`<br>module. | <pre>object({<br>    id   = optional(string)<br>    name = string<br>  })</pre> | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope where the role will be assigned. Must provide either `id` or both<br>`display_name` and `type`. Scope `type` can either be `management_group`,<br>`resource_group`, or `subscription`. | <pre>object({<br>    display_name = optional(string)<br>    id           = optional(string)<br>    type         = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_service_principal_ids"></a> [service\_principal\_ids](#input\_service\_principal\_ids) | The ID of service principals to assign to the role. The key is the key of the app<br>registration and the value is the ID of the service principal associated with it. | `map(string)` | `{}` | no |
| <a name="input_user_principal_names"></a> [user\_principal\_names](#input\_user\_principal\_names) | The UPN of users to assign to the role | `set(string)` | `[]` | no |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.service_principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_user.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_management_group.scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_resource_group.scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscriptions.scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Examples

```hcl
# Example 1 - Assigning a group to a custom role at a subscription
role_assignments = {
  "Grant group access to sub" = {
    group_display_names = ["AZ_COMM_CORP_ADMIN"]
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-corp-infraops-dev-01"
      type = "subscription"
    }
  }
}

# Example 2 - Assigning a managed identity to a custom role at a subscription
role_assignments = {
  "Grant managed identity access to sub" = {
    managed_identity_keys = ["id-private-endpoint-dns-configuration"]
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-corp-infraops-dev-01"
      type = "subscription"
    }
  }
}


# Example 3 - Assigning a user to a custom role at a management group
role_assignments = {
  "Grant user access to sub" = {
    group_display_names = ["AZ_COMM_CORP_ADMIN"]
    managed_identity_keys = ["id-private-endpoint-dns-configuration"]
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "Parsons"
      type = "management_group"
    }
    user_principal_names = ["a008851G@Parsons.com"]
  }
}


# Example 4 - Assigning an app registration/service principal at a subscription
role_assignments = {
  "Grant service account access to sub" = {
    app_registration_keys = ["_sys_platform_terragrunt_admin"]
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-corp-infraops-dev-01"
      type = "subscription"
    }
  }
}

# Example 5 - Assigning a role to a user using scope ID from another deployment
# In this example the parent folder will deploy a storage account with the key
# "stpowerbisevenprogram"

# terragrunt.hcl:
include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "storage" {
  config_path = "../"
}

inputs = {
  role_assignments = {
    "Grant access to stpowerbisevenprogram" = {
      role_name = "role-parsons-alz-admin"
      scope = {
        id = dependency.storage.outputs.storage_accounts["stpowerbisevenprogram"].id
      }
      user_principal_names = [
        "mohamed.sabbah@parsons.com",
      ]
    }
  }
}
```
<!-- END_TF_DOCS -->