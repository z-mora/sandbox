resource "azurerm_virtual_hub_connection" "vnet_to_hub" {
  count    = coalesce(var.is_dmz, true) ? 0 : 1 # Use coalesce() because var.is_dmz can be null
  provider = azurerm.corp_network

  internet_security_enabled = true
  name                      = "hubconn-${var.name}"
  remote_virtual_network_id = azurerm_virtual_network.this.id
  virtual_hub_id            = data.azurerm_virtual_hub.corp.id

  lifecycle {
    # Ignore changes to name for backwards compatibility to avoid recreating older hub
    # connections that had a different naming scheme. It was shortened due to length
    ignore_changes = [name]
  }
}

resource "azurerm_virtual_network_peering" "vnet_to_palo_alto_vnet" {
  count = coalesce(var.is_dmz, false) ? 1 : 0

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
  name                         = "vnetpeer-${data.azurerm_virtual_network.corp_firewall.name}-${var.name}"
  remote_virtual_network_id    = data.azurerm_virtual_network.corp_firewall.id
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.name

  triggers = {
    "remote_address_space" = join(",", data.azurerm_virtual_network.corp_firewall.address_space)
  }
}

resource "azurerm_virtual_network_peering" "palo_alto_vnet_to_vnet" {
  count    = coalesce(var.is_dmz, false) ? 1 : 0
  provider = azurerm.corp_network

  allow_forwarded_traffic      = false
  allow_virtual_network_access = true
  name                         = "vnetpeer-${data.azurerm_virtual_network.corp_firewall.name}-${var.name}"
  remote_virtual_network_id    = azurerm_virtual_network.this.id
  resource_group_name          = "rg-network-prod-01"
  virtual_network_name         = data.azurerm_virtual_network.corp_firewall.name

  triggers = {
    "remote_address_space" = join(",", azurerm_virtual_network.this.address_space)
  }
}

resource "azurerm_virtual_hub_route_table_route" "to_vnet" {
  count    = coalesce(var.is_dmz, false) ? 1 : 0
  provider = azurerm.corp_network

  destinations      = var.cidr
  destinations_type = "CIDR"
  name              = "route-${var.name}"
  next_hop          = data.azurerm_virtual_hub_connection.to_firewall_vnet.id
  next_hop_type     = "ResourceId"
  route_table_id    = data.azurerm_virtual_hub.corp.default_route_table_id
}
