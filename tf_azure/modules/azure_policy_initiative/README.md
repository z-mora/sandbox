<!-- BEGIN_TF_DOCS -->
# azure_policy_initiative

This module allows you to deploy an Azure policy initiative (also known as a policy set
definition) with groups, assignments, and exemptions. It's recommended to use a policy
initiative for assignment even if you only plan on adding a single policy definition to
it initially.

There are a few limitations for this module, based on what our needs appear to be:

* The only scopes supported for assigning an initiative are `management_group` and
`subscription`
* You can only add an exemption for a `management_group` assignment, and the exemption
can only be at the scope `management_group` or `subscription`

## Policy Definition & Assignment/Exemption Scope Names

For policy definitions, assignments, and exemptions, the item's key must be the display
name of the object that should be looked up via data source. Some lookups may return
more than 1 value. If that's the case, the first result will be used.

## Parameters

Initiative parameters are different than policy definition parameters. You'll typically
want to set unique parameter values for each individual policy definition that you add
to the initiative. Initiative parameters would be helpful if you have a single parameter
that you want all policy definitions to share.

## Name vs Display Name

While setting `name` is required for the resources in this module, the name itself is
not visible in the Azure portal. `name` will typically get set to the resource instance
key and `display_name` is also required, which is what you'll see in the portal.

## Additional Info

* [What is Azure Policy?](https://learn.microsoft.com/en-us/azure/governance/policy/overview)
* [azurerm_policy_set_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition)
* [azurerm_management_group_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)
* [azurerm_management_group_policy_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption)
* [azurerm_subscription_policy_assignment](azurerm_subscription_policy_assignment)
* [azurerm_subscription_policy_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption)
* [azurerm_subscription_policy_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption)
* [Azure Policy Initiatives vs Azure Policies: When should I use one over the other?](
  https://techcommunity.microsoft.com/t5/itops-talk-blog/azure-policy-initiatives-vs-azure-policies-when-should-i-use-one/ba-p/1229167
)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Optional assignments to assign the policy initiative to management groups or<br>  subscriptions. | <pre>map(object({<br>    description = optional(string)<br>    enforce     = optional(bool, true)<br>    identity = optional(object({<br>      identity_ids = optional(list(string))<br>      type         = string<br>    }))<br>    location   = optional(string, "eastus2")<br>    scope_type = string<br>    exemptions = optional(map(object({<br>      category     = string<br>      description  = optional(string)<br>      display_name = string<br>      scope_type   = string<br>    })), {})<br>  }))</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy set definition. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the policy set definition. If not specified, this will be set to<br>the name. | `string` | n/a | yes |
| <a name="input_management_group_display_name"></a> [management\_group\_display\_name](#input\_management\_group\_display\_name) | The ID of the Management Group where this policy set definition should be defined.<br>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | The metadata for the policy set definition, such as category. | `map(any)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy set definition. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for the policy set definition. | `map(any)` | `null` | no |
| <a name="input_policy_definition_groups"></a> [policy\_definition\_groups](#input\_policy\_definition\_groups) | Groups you can have created within the initiative to group the policy definitions<br>that are added. | <pre>map(object({<br>    category     = optional(string)<br>    description  = optional(string)<br>    display_name = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_policy_definition_references"></a> [policy\_definition\_references](#input\_policy\_definition\_references) | Existing policies to add to the initiative. They can be either custom or built-in.<br>If any groups are specified, they must be defined in `policy_definition_groups`.<br>The key must be an existing policy's `display_name`, so it can be looked up using a<br>data source.<br><br>`definition_display_name` is intended to be used if you'd like to add the same<br>policy definition more than once. The map key still must be unique, so append<br>something to the end such as the group ID or another reason for the duplicate policy.<br>See the examples.<br><br>> NOTE: `display_name` is not unique, so if there's more than 1 policy with the same<br>> display name you will run into issues | <pre>map(object({<br>    definition_display_name = optional(string)<br>    parameters = optional(map(object({<br>      list_value   = optional(list(string))<br>      string_value = optional(string)<br>    })), {})<br>    reference_id       = optional(string)<br>    policy_group_names = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the policy initiative |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_management_group_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption) | resource |
| [azurerm_policy_set_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |
| [azurerm_subscription_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption) | resource |
| [azurerm_management_group.assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.initiative_destination](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_policy_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_subscriptions.exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |
| [azurerm_subscriptions.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Examples

```hcl
# Example 1 - Initiative with a single policy definition in a group
policy_initiatives = {
  mike_test_initiative = {
    description = "Test initiative"
    display_name = "Mike's test policy initiative"
    management_group_display_name = "Tenant Root Group"
    metadata = {
      category = "Network"
    }
    policy_definition_groups = {
      Search = {
        category = "Search"
      }
    }
    policy_definition_references = {
      "Configure Azure Cognitive Search services to use private DNS zones" = {
        parameters = {
          privateDnsZoneId = {
            value = "/subscriptions/e45d6712-fcba-4a53-bcef-9f8817d2632a/resourceGroups/rg-dns-prod-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"
          }
        }
        policy_group_names = ["Search"]
      }
    }
  }
}

# Example 2 - Initiative with multiple assignments and exemptions
policy_initiatives = {
  mike_test_initiative = {
    assignments = {
      sub-comm-corp-alz-dev-01 = {
        identity = { type = "SystemAssigned" }
        scope_type = "subscription"
      }
      mg-suspended-01 = {
        exemptions = {
          sub-comm-corp-infraops-dev-01 = {
            category = "Waiver"
            description = "testing"
            display_name = "Exempt sub-comm-corp-infraops-dev-01 from mike_test_initiative"
            scope_type = "subscription"
          }
          mike-test-exemption = {
            category = "Waiver"
            description = "testing"
            display_name = "Exempt mike-test-exemption from mike_test_initiative"
            scope_type = "management_group"
          }
        }
        identity = { type = "SystemAssigned" }
        scope_type = "management_group"
      }
    }
    description = "Test initiative"
    display_name = "Mike's test policy initiative"
    management_group_display_name = "Tenant Root Group"
    metadata = { category = "Network" }
    policy_definition_groups = {
      Search = { category = "Search" }
    }
    policy_definition_references = {
      "Configure Azure Cognitive Search services to use private DNS zones" = {
        parameters = {
          privateDnsZoneId = {
            value = "/subscriptions/e45d6712-fcba-4a53-bcef-9f8817d2632a/resourceGroups/rg-dns-prod-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"
          }
        }
        policy_group_names = ["Search"]
      }
    }
  }
}

# Example 3 - Initiative with the same policy definition added more than once
policy_initiatives = {
  mike_test_initiative = {
    description = "Test initiative"
    display_name = "Mike's test policy initiative"
    management_group_display_name = "Tenant Root Group"

    policy_definition_references = {
      "Configure Azure Automation accounts with private DNS zones - Webhook" = {
        definition_display_name = "Configure Azure Automation accounts with private DNS zones"
        parameters = {
          privateDnsZoneId = {
            value = "/subscriptions/e45d6712-fcba-4a53-bcef-9f8817d2632a/resourceGroups/rg-dns-prod-01/providers/Microsoft.Network/privateDnsZones/privatelink.azure-automation.net"
          }
          privateEndpointGroupId = {
            value = "Webhook"
          }
        }
      }
      "Configure Azure Automation accounts with private DNS zones - DSCAndHybridWorker" = {
        definition_display_name = "Configure Azure Automation accounts with private DNS zones"
        parameters = {
          privateDnsZoneId = {
            value = "/subscriptions/e45d6712-fcba-4a53-bcef-9f8817d2632a/resourceGroups/rg-dns-prod-01/providers/Microsoft.Network/privateDnsZones/privatelink.azure-automation.net"
          }
          privateEndpointGroupId = {
            value = "DSCAndHybridWorker"
          }
        }
      }
    }
  }
}
```
<!-- END_TF_DOCS -->