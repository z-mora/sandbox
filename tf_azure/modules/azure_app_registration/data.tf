data "azuread_client_config" "current" {}

data "azuread_service_principal" "api" {
  for_each = var.api_permissions

  display_name = each.key
}
