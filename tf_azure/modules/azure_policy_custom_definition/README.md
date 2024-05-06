<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | description of the custom policy | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the custom policy definition. This is what you'll see in the portal. | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | management group id where this custom policy will reside | `string` | n/a | yes |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Key value pairs of policy metadata that will be converted to a JSON string | `map(any)` | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | The policy resource manager mode that allows you to specify which resource types will<br>be evaluated. For possible values, see:<br>https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#mode | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the custom policy | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Policy parameters that will be converted to a JSON string | <pre>map(object({<br>    allowedValues = optional(list(string))<br>    defaultValue  = optional(string)<br>    type          = string<br>    metadata = optional(object({<br>      assignPermissions = optional(bool)<br>      description       = optional(string)<br>      displayName       = optional(string)<br>      strongType        = optional(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | JSON string of the policy definition | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | the id for the custom policy |

## Resources

| Name | Type |
|------|------|
| [azurerm_policy_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Examples

```hcl
## custom policy definition when using a separate json file for the policy rule, with the policy definition map located in terragrunt.hcl 
## The json file is located in the same folder as the .hcl file

custom_policy_definition = {
  "Configure a private DNS Zone ID for table groupID - Custom" = {
    mode         = "Indexed"
    display_name = "Configure a private DNS Zone ID for table groupID - Custom"
    description  = "Configure private DNS zone group to override the DNS resolution for a table groupID private endpoint."
    metadata = {
      version  = "1.0.0"
      category = "Storage"
    }
    parameters = {
      privateDnsZoneId = {
        type = "String"
        metadata = {
          description      = "Configure a private DNS Zone ID for table groupID"
          displayName      = "Configure private DNS zone group to override the DNS resolution for a table groupID private endpoint."
          strongType       = "Microsoft.Network/privateDnsZones"
          assignPermissions = true
        }
      }
      effect = {
        type = "string"
        metadata = {
          displayName = "Effect"
          description = "Enable or disable the execution of the policy"
        }
        allowedValues = ["DeployIfNotExists", "Disabled"]
        defaultValues = "DeployIfNotExists"
      }
    }
    policy_rule = file("custom_policy.json")
  }
}

## custom policy definition when putting the policy rule in a multi-line string variable, this would be located in the 
## .tfvars file

custom_policy_definition = {
  "Configure a private DNS Zone ID for table groupID - Custom" = {
    mode         = "Indexed"
    display_name = "Configure a private DNS Zone ID for table groupID - Custom"
    description  = "Configure private DNS zone group to override the DNS resolution for a table groupID private endpoint."
    metadata = {
      version  = "1.0.0"
      category = "Storage"
    }
    parameters = {
      privateDnsZoneId = {
        type = "String"
        metadata = {
          description      = "Configure a private DNS Zone ID for table groupID"
          displayName      = "Configure private DNS zone group to override the DNS resolution for a table groupID private endpoint."
          strongType       = "Microsoft.Network/privateDnsZones"
          assignPermissions = true
        }
      }
      effect = {
        type = "string"
        metadata = {
          displayName = "Effect"
          description = "Enable or disable the execution of the policy"
        }
        allowedValues = ["DeployIfNotExists", "Disabled"]
        defaultValues = "DeployIfNotExists"
      }
    }
    policy_rule = <<POLICY_RULE
      {
        "if": {
          "not": {
            "field": "location",
            "in": "[parameters('allowedLocations')]"
          }
        },
        "then": {
          "effect": "audit"
        }
      }
    POLICY_RULE
  }
}
```
<!-- END_TF_DOCS -->