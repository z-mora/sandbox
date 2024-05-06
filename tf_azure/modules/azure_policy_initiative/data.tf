data "azurerm_management_group" "initiative_destination" {
  count = var.management_group_display_name == null ? 0 : 1

  display_name = var.management_group_display_name
}

data "azurerm_policy_definition" "this" {
  for_each = var.policy_definition_references

  display_name = coalesce(each.value.definition_display_name, each.key)
}

# If more than 1 subscription is found, the first result will be used
data "azurerm_subscriptions" "this" {
  for_each = { for k, v in var.assignments : k => v if v.scope_type == "subscription" }

  display_name_contains = each.key
}

data "azurerm_management_group" "assignment" {
  for_each = { for k, v in var.assignments : k => v if v.scope_type == "management_group" }

  display_name = each.key
}

data "azurerm_management_group" "exemption" {
  for_each = { for k, v in local.exemptions : k => v if v.scope_type == "management_group" }

  display_name = each.value.scope_display_name
}

# If more than 1 subscription is found, the first result will be used
data "azurerm_subscriptions" "exemption" {
  for_each = { for k, v in local.exemptions : k => v if v.scope_type == "subscription" }

  display_name_contains = each.value.scope_display_name
}
