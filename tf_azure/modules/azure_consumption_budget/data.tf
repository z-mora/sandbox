data "azurerm_subscription" "current" {}

data "azurerm_management_group" "this" {
  count = var.type == "mg" ? 1 : 0

  name = var.management_group_name
}

data "azurerm_resource_group" "this" {
  count = var.type == "rg" ? 1 : 0

  name = var.resource_group_name
}
