# azure_policy

This module allows you to deploy policy assignments, definitions, and any exemptions for Azure Policy
management.

Assignments -
  Policy assignments are used by Azure Policy to define which resources are assigned which policies. The policy assignment can determine the values of parameters for that group of resources at assignment time, making it possible to reuse policy definitions that address the same resource properties with different needs for compliance.

Definitions -
  Policy definitions describe resource compliance conditions and the effect to take if a condition is met.
  A condition compares a resource property field or a value.

Exemptions -
  The Azure Policy exemptions feature is used to exempt a resource hierarchy or an individual resource from evaluation of a policy definition. Resources that are exempt count toward overall compliance, but can't be evaluated or have a temporary waiver.

# Assignments and Exemptions

 Assignments and Exemptions are created within the .tfvars file. The scope for either an assignment or exemption can be an individual resource, a resource group, a subscription, or a management group. An assignment is what tells Azure what resources to enforce the definition policies on. Without an assignment using a definition, there will be nothing enforcing compliance.

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
