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
