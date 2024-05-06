resource "azurerm_resource_policy_exemption" "this" {
  for_each = {
    for name, exemption in var.built_in_exemptions :
    name => exemption if exemption.scope == "r"
  }

  exemption_category   = each.value.category
  name                 = each.key
  policy_assignment_id = azurerm_resource_policy_assignment.this[each.value.assignment_name].id
  resource_id          = each.value.scope_id
}

resource "azurerm_resource_group_policy_exemption" "this" {
  for_each = {
    for name, exemption in var.built_in_exemptions :
    name => exemption if exemption.scope == "rg"
  }

  exemption_category   = each.value.category
  name                 = each.key
  policy_assignment_id = azurerm_resource_group_policy_assignment.this[each.value.assignment_name].id
  resource_group_id    = each.value.scope_id
}

resource "azurerm_subscription_policy_exemption" "this" {
  for_each = {
    for name, exemption in var.built_in_exemptions :
    name => exemption if exemption.scope == "sub"
  }

  exemption_category   = each.value.category
  name                 = each.key
  policy_assignment_id = azurerm_subscription_policy_assignment.this[each.value.assignment_name].id
  subscription_id      = each.value.scope_id
}

resource "azurerm_management_group_policy_exemption" "this" {
  for_each = {
    for name, exemption in var.built_in_exemptions :
    name => exemption if exemption.scope == "mg"
  }

  exemption_category   = each.value.category
  management_group_id  = each.value.scope_id
  name                 = each.key
  policy_assignment_id = azurerm_management_group_policy_assignment.this[each.value.assignment_name].id
}
