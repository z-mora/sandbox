resource "azurerm_route_table" "this" {
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  location                      = var.location
  name                          = var.name
  resource_group_name           = var.resource_group_name
  tags                          = var.required_tags
}

resource "azurerm_route" "this" {
  for_each = var.routes

  address_prefix = each.value.address_prefix
  name           = each.key
  next_hop_in_ip_address = (
    each.value.next_hop_type == "VirtualAppliance" ? (
      each.value.next_hop_in_ip_address == "TBD" ?
      data.azurerm_lb.firewall_ilb[each.key].private_ip_address :
      each.value.next_hop_in_ip_address
    ) : null
  )
  next_hop_type       = each.value.next_hop_type
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.this.name
}
