data "azuread_group" "this" {
  for_each = var.group_display_names

  display_name     = each.value
  security_enabled = true
}

data "azuread_user" "this" {
  for_each = var.user_principal_names

  user_principal_name = each.value
}

data "azurerm_management_group" "scope" {
  count = var.scope.type == "management_group" ? 1 : 0

  display_name = var.scope.display_name
}

data "azurerm_resource_group" "scope" {
  count = var.scope.type == "resource_group" ? 1 : 0

  name = var.scope.display_name
}

data "azurerm_subscriptions" "scope" {
  count = var.scope.type == "subscription" ? 1 : 0

  display_name_contains = var.scope.display_name
}
