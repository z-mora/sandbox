data "azurerm_lb" "firewall_ilb" {
  for_each = { for k, v in var.routes : k => v if v.next_hop_in_ip_address == "TBD" }
  provider = azurerm.corp_network

  name                = "lb-paloalto-${var.location}-ilb-01"
  resource_group_name = "rg-network-prod-01"
}
