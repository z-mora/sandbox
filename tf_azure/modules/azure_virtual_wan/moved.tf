moved {
  from = azurerm_virtual_wan.virtual_wans
  to   = azurerm_virtual_wan.this
}

moved {
  from = azurerm_virtual_hub.virtual_hub
  to   = azurerm_virtual_hub.this
}

moved {
  from = azurerm_virtual_hub_connection.virtual_hub_connection
  to   = azurerm_virtual_hub_connection.to_palo_alto_vnet
}

moved {
  from = azurerm_vpn_site.vpn_sites
  to   = azurerm_vpn_site.this
}

moved {
  from = azurerm_vpn_gateway.vpn_gateways
  to   = azurerm_vpn_gateway.this
}

moved {
  from = azurerm_vpn_gateway_connection.vpn_gateway_connections
  to   = azurerm_vpn_gateway_connection.hub_gateway_to_vpn_site
}
