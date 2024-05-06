
data "azurerm_subnet" "this" {
  for_each = local.interfaces

  name                 = each.value.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = each.value.vnet_name
}
