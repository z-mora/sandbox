resource "azurerm_private_dns_resolver_virtual_network_link" "this" {
  count    = var.link_dns_hub_forwarding_ruleset ? 1 : 0
  provider = azurerm.dns_hub

  dns_forwarding_ruleset_id = data.azurerm_private_dns_resolver_dns_forwarding_ruleset.this[0].id
  name                      = "${azurerm_virtual_network.this.name}-link"
  virtual_network_id        = azurerm_virtual_network.this.id
}
