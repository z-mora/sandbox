resource "azurerm_resource_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.policy_assignments :
    name => assignment if assignment.scope == "r"
  }

  enforce              = each.value.enforce
  policy_definition_id = azurerm_policy_set_definition.this.id
  name                 = each.key
  resource_id          = each.value.scope_id
}

resource "azurerm_resource_group_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.policy_assignments :
    name => assignment if assignment.scope == "rg"
  }

  enforce              = each.value.enforce
  policy_definition_id = azurerm_policy_set_definition.this.id
  name                 = each.key
  resource_group_id    = each.value.scope_id
}

resource "azurerm_subscription_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.policy_assignments :
    name => assignment if assignment.scope == "sub"
  }

  enforce              = each.value.enforce
  policy_definition_id = azurerm_policy_set_definition.this.id
  name                 = each.key
  subscription_id      = each.value.scope_id
}

resource "azurerm_management_group_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.policy_assignments :
    name => assignment if assignment.scope == "mg"
  }

  enforce              = each.value.enforce
  policy_definition_id = azurerm_policy_set_definition.this.id
  management_group_id  = each.value.scope_id
  name                 = each.key
}
