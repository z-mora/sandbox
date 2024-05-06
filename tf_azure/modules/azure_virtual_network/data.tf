data "azurerm_virtual_hub" "corp" {
  provider = azurerm.corp_network

  name                = "hub-${var.location}-prod-01"
  resource_group_name = "rg-network-prod-01"
}

data "azurerm_virtual_network" "corp_firewall" {
  provider = azurerm.corp_network

  name                = local.corp_firewall_vnet_name
  resource_group_name = "rg-network-prod-01"
}

data "azurerm_virtual_hub_connection" "to_firewall_vnet" {
  provider = azurerm.corp_network

  name                = "hubconn-${data.azurerm_virtual_hub.corp.name}-${local.corp_firewall_vnet_name}"
  resource_group_name = "rg-network-prod-01"
  virtual_hub_name    = data.azurerm_virtual_hub.corp.name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_virtual_network.this.id
}

data "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  count    = var.link_dns_hub_forwarding_ruleset ? 1 : 0
  provider = azurerm.dns_hub

  name                = "dnsfrs-hub-prod-${var.location}-01"
  resource_group_name = "rg-dns-prod-01"
}
