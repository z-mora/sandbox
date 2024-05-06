
resource "azurerm_role_assignment" "resource" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "r" && assignment.role_assignment_needed == true
  }

  scope                = each.value.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_resource_policy_assignment.this[each.key].identity[0].principal_id
}

resource "azurerm_role_assignment" "resource_group" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "rg" && assignment.role_assignment_needed == true
  }

  scope                = each.value.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_resource_group_policy_assignment.this[each.key].identity[0].principal_id
}

resource "azurerm_role_assignment" "subscription" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "sub" && assignment.role_assignment_needed == true
  }

  scope                = each.value.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_subscription_policy_assignment.this[each.key].identity[0].principal_id
}

resource "azurerm_role_assignment" "management_group" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "mg" && assignment.role_assignment_needed == true
  }

  scope                = each.value.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_management_group_policy_assignment.this[each.key].identity[0].principal_id
}
