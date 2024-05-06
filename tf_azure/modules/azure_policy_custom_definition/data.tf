data "azurerm_management_group" "this" {
  name = var.management_group_id == null ? "8d088ff8-7e52-4d0f-8187-dcd9ca37815a" : var.management_group_id
}
