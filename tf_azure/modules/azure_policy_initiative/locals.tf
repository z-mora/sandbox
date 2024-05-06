locals {
  exemptions = merge([
    for a_key, a in var.assignments : {
      for e_key, e in a.exemptions : "${a_key}:${e_key}" => merge({
        policy_assignment_id = (
          a.scope_type == "management_group" ?
          azurerm_management_group_policy_assignment.this[a_key].id :
          azurerm_subscription_policy_assignment.this[a_key].id
        )
        scope_display_name = e_key
      }, e)
    }
  ]...)
}
