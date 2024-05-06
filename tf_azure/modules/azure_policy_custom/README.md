<!-- BEGIN_TF_DOCS -->
# azure_policy_custom

This module allows you to deploy policy assignments, definitions, exemptions, and initiatives for Azure Policy
management.

Assignments -
  Policy assignments are used by Azure Policy to define which resources are assigned which policies or initiatives. The policy assignment can determine the values of parameters for that group of resources at assignment time, making it possible to reuse policy definitions that address the same resource properties with different needs for compliance.

Definitions -
  Policy definitions describe resource compliance conditions and the effect to take if a condition is met.
  A condition comapres a resource property field or a value. Custom Definitions must be defined as a .json file.

Exemptions -
  The Azure Policy exemptions feature is used to exempt a resource hierarchy or an individual resource from evaluation of initiatives or definitions. Resources that are exempt count toward overall compliance, but can't be evaluated or have a temporary waiver.

Initiatives -
  Policy Initiatives are used to group multiple Policy Definitions together. It is best practice to include even single definitions
  into their own initiatives.

# Initiatives and Definitions

 Initiatives are outlined in a YAML file. This file details each definition within the initiative and adds any parameter information needed by the definition. This YAML file needs to be within the /policies/{initiative_name} folder, and be called initiative_definition.yaml

 Custom Definitions need to be defined within their Initiatives' folder and be named {definition_name}.json. Built-In Definitions do not need this, as they are defined within Azure already, and are called within the initiative_definition.yaml file.

 Note: All custom definitions should be created in the root management group. This allows any lower management group to also use the custom definition.

# Assignments and Exemptions

 Assignments and Exemptions are created within the .tfvars file. The scope for either an assignment or exemption can be an individual resource, a resource group, a subscription, or a management group. An assignment is what tells Azure what resources to enforce the definition policies on. Without an assignment using an initiative/definition, there will be nothing enforcing compliance.

 An exemption allows us to specify specific groups or resources within an assignment to be ignored by the policy.

## Additional Info

* [What is Azure Policy?](https://learn.microsoft.com/en-us/azure/governance/policy/overview)
* [azurerm_subscription_policy_assignment](azurerm_subscription_policy_assignment)
* [azurerm_policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
* [azurerm_subscription_policy_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption)
* [Initiaitve Definition Structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure)
* [Exemption Structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure)
* [Definition Structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)
* [Assignment Structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/assignment-structure)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initiative_definition_name"></a> [initiative\_definition\_name](#input\_initiative\_definition\_name) | name of the policy initiative | `string` | n/a | yes |
| <a name="input_policy_assignments"></a> [policy\_assignments](#input\_policy\_assignments) | policy assignment set | <pre>map(object({<br>    enforce         = bool<br>    initiative_name = string<br>    scope           = string<br>    scope_id        = string<br>  }))</pre> | n/a | yes |
| <a name="input_policy_exemptions"></a> [policy\_exemptions](#input\_policy\_exemptions) | A map of resources, resource groups, subscriptions, or management groups to exclude<br>  from the specified policy assignment. | <pre>map(object({<br>    assignment_name = string<br>    category        = string<br>    scope           = string<br>    scope_id        = string<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_management_group_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption) | resource |
| [azurerm_policy_definition.custom_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_policy_set_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |
| [azurerm_resource_group_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) | resource |
| [azurerm_resource_group_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption) | resource |
| [azurerm_resource_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment) | resource |
| [azurerm_resource_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption) | resource |
| [azurerm_subscription_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_exemption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption) | resource |
| [azurerm_policy_definition.built_in](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |

## Examples

```hcl
# Assignment with an exemption Example-
policies = {
  "example-policy" = {
    initiative_definition_name = "test_initiative"
    policy_assignment = {
      "assignment-example" = {
         enforce         = false
         initiative_name = "test_initiative"
         scope           = "rg"
         scope_id        = "/subscriptions/d5fb8c13-907c-4c33-8021-d5457490856b/resourceGroups/rg-cps-prod-01"
      }
    }
    policy_exemptions = {
       "exemption-example" = {
         assignment_name = "assignment-example"
         category        = "Mitigated"
         scope           = "rg"
         scope_id        = "/subscriptions/d5fb8c13-907c-4c33-8021-d5457490856b/resourceGroups/rg-cps-prod-01"
       }
     }
  }
}

# Initiative with custom and built-in definition
# this would be located in /policies/test_initiative within the terragrunt implementation
# This initiative has 2 definitions
# -(Custom) Blocked locations - blocks login from specific regions
# -(Built-In) SQL Server Integration - Note the id is needed for a built in policy, this is pulled from Azure
name: 'test_initiative'
display_name: test initiative
description: test initiative
policies:
  BlockedLocations:
    type: 'Custom'
    file: test_initiative/blocked_locations.json
    management_group_id: mg-infra-prod-01
    parameters:
      listOfBlockedLocations:
        value:
          - australiaeast
  SQL Server Integration Services integration runtimes on Azure Data Factory should be joined to a virtual network:
    type: 'BuiltIn'
    id: 0088bc63-6dee-4a9c-9d29-91cfdc848952
    parameters:

# Custom definition
# This definition would be in the same folder as the above Initiative Definition
{
  "properties": {
    "displayName": "Blocked locations",
    "policyType": "Custom",
    "mode": "All",
    "description": "This policy enables you to restrict the locations your organization can't specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region.",
    "metadata": {
      "version": "1.0.0",
      "category": "General"
    },
    "parameters": {
      "listOfBlockedLocations": {
        "type": "Array",
        "metadata": {
          "description": "The list of locations that can't be specified when deploying resources.",
          "strongType": "location",
          "displayName": "Blocked locations"
        }
      }
    },
    "policyRule": {
      "if": {
        "field": "location",
        "in": "[parameters('listOfBlockedLocations')]"
      },
      "then": {
        "effect": "audit"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->