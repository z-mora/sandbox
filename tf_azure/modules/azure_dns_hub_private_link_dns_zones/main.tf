resource "azurerm_private_dns_zone" "this" {
  for_each = local.zone_names

  name                = each.key
  resource_group_name = var.resource_group_name
  tags                = var.required_tags

}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.zones_and_vnets

  name                  = "link-${each.value.vnet_key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone_name].name
  tags                  = var.required_tags
  virtual_network_id    = var.vnet_ids[each.value.vnet_key]
}
