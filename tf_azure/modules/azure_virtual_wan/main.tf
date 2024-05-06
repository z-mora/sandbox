resource "azurerm_virtual_wan" "this" {
  allow_branch_to_branch_traffic = var.allow_branch_to_branch_traffic
  disable_vpn_encryption         = var.disable_vpn_encryption
  location                       = var.location
  name                           = var.virtual_wan_name
  resource_group_name            = var.resource_group_name
  tags                           = var.required_tags
  type                           = var.type # Options are Basic or Standard
}

resource "azurerm_virtual_hub" "this" {
  for_each = var.virtual_hubs

  address_prefix      = each.value.virtual_hub_address_prefix
  location            = each.value.location
  name                = each.key
  resource_group_name = var.resource_group_name
  tags                = var.required_tags
  virtual_wan_id      = azurerm_virtual_wan.this.id
}

resource "azurerm_virtual_hub_connection" "to_palo_alto_vnet" {
  for_each = var.virtual_hubs

  internet_security_enabled = each.value.internet_security_enabled
  name                      = "hubconn-${each.key}-${each.value.remote_virtual_network_name}"
  remote_virtual_network_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value.remote_virtual_network_name}"
  virtual_hub_id            = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualHubs/${each.key}"
}
