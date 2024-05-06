<!-- BEGIN_TF_DOCS -->
# azure_consumption_budget

This module allows you to build and configure an Azure consumption budget at either a
subscription, management group, or resource group level.

## Additional Info

* [What is Microsoft Cost Management](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/overview-cost-management)
* [azurerm_consumption_budget_subscription_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription_group)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amount"></a> [amount](#input\_amount) | dollar amount the budget should be set to | `number` | n/a | yes |
| <a name="input_consumption_budget_name"></a> [consumption\_budget\_name](#input\_consumption\_budget\_name) | key value of each consumption budget, used to name the budget | `string` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | consumption budget dimension | <pre>map(object({<br>    name     = string<br>    operator = optional(string)<br>    values   = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | end date for the budget | `string` | `null` | no |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | the name of the management group the budget will be applied to | `string` | `null` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | notifications for the consumption budget | <pre>map(object({<br>    contact_emails = optional(list(string), null)<br>    contact_groups = optional(list(string), null)<br>    contact_roles  = optional(list(string), null)<br>    enabled        = optional(bool)<br>    operator       = string<br>    threshold      = number<br>    threshold_type = optional(string, null)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | the name of the resource group the budget will be applied to | `string` | `null` | no |
| <a name="input_start_date"></a> [start\_date](#input\_start\_date) | start date for the budget | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | consumption budget tags | <pre>map(object({<br>    name     = string<br>    operator = optional(string)<br>    values   = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_time_grain"></a> [time\_grain](#input\_time\_grain) | time grain (monthly, annually, etc) used by the consumption budget | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | the type of consumption budget (subscription {sub}, management group {mg}, or resource group {rg}) | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_consumption_budget_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) | resource |
| [azurerm_consumption_budget_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Examples

```hcl
# Example 1 - Resource group budget
consumption_budgets = {
  "test_resource_group_budget" = {
    amount              = 1000
    end_date            = "2024-07-01T00:00:00Z"
    notifications = {
      "notify_hunter_greaterthan_100" = {
        contact_emails = [
          "hunter.hawthorne@parsons.com"
        ]
        enabled = false
        operator  = "GreaterThan"
        threshold = 100
      }
    }
    resource_group_name = "rg-cps-prod-01"
    start_date          = "2023-07-01T00:00:00Z"
    type                = "rg"
  }
}
```
<!-- END_TF_DOCS -->