# azure_policy_custom_definition

This module allows you to create custom policy definitions. Microsoft's policy definition structure doc can be found here - <https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure>

## Passing JSON strings

Several of the attributes in this module require a json string (metadata, parameters, and policy_rule). We define the JSON structure for these attributes differently.

### metadata and parameters

These are defined as hcl objects in the terragrunt variable declaration.

### policy_rule

policy rule has 2 methods for defining its JSON structure.

#### terragrunt.hcl

This method is used for large policy rules that will benefit from the readbility provided by Visual Studio
Code when the JSON string is in its own JSON file. This method requires the policy rule JSON string to be
in a .json file in the same folder location as the terragrunt .tfvars and .hcl files. Along with the new
json file, the variable implementation of the policy must be put in the "inputs" block within the terragrunt.hcl
file. Terragrunt's "file()" command is used to pull the json file into terraform as a string.

#### multi-line string

This method is used for smaller policy rules as it has the policy rule put into a multi-line string variable in the .tfvars
file. This means that syntax coloring for the json code is unavailable. However the policy declaration is found
in the azure_policy_custom.tfvars file, so it is found easily.

Both methods have examples in examples.txt

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
