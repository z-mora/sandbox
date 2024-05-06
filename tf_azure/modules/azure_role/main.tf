resource "azurerm_role_definition" "this" {
  description = var.role_description
  name        = var.role_name
  scope       = var.scope

  permissions {
    actions          = var.actions
    data_actions     = var.data_actions
    not_actions      = var.not_actions
    not_data_actions = var.not_data_actions
  }
}
