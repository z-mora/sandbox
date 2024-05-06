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
