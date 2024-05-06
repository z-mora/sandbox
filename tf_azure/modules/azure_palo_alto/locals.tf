locals {
  # Convert interfaces list to map and save index
  interfaces = { for k, v in var.interfaces : v.name => merge(v, { index = k }) }
  # Keep ordered list of interface IDs
  network_interface_ids = [
    for k, v in var.interfaces : azurerm_network_interface.this[v.name].id
  ]
  primary_network_interface_id = azurerm_network_interface.this[var.interfaces[0].name].id
}
