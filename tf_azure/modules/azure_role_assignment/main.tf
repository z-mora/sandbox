resource "azurerm_role_assignment" "group" {
  for_each = var.group_display_names

  principal_id         = data.azuread_group.this[each.key].id
  role_definition_name = var.role.name
  scope                = local.scope
}

resource "azurerm_role_assignment" "managed_identity" {
  for_each = var.managed_identity_ids

  principal_id         = each.value
  role_definition_name = var.role.name
  scope                = local.scope
}

resource "azurerm_role_assignment" "service_principal" {
  for_each = var.service_principal_ids

  principal_id         = each.value
  role_definition_name = var.role.name
  scope                = local.scope
}

resource "azurerm_role_assignment" "user" {
  for_each = var.user_principal_names

  principal_id         = data.azuread_user.this[each.key].id
  role_definition_name = var.role.name
  scope                = local.scope
}
