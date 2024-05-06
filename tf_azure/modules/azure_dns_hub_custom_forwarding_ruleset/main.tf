resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  location                                   = var.location
  name                                       = var.name
  private_dns_resolver_outbound_endpoint_ids = [data.azurerm_private_dns_resolver_outbound_endpoint.this.id]
  resource_group_name                        = var.resource_group_name
  tags                                       = var.required_tags
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  for_each = var.rules

  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  domain_name               = "${each.key}."
  enabled                   = each.value.enabled
  name                      = replace(each.key, ".", "_")

  dynamic "target_dns_servers" {
    for_each = each.value.target_dns_servers
    content {
      ip_address = split(":", target_dns_servers.value)[0]
      port       = split(":", target_dns_servers.value)[1]
    }
  }
}

resource "azurerm_private_dns_resolver_virtual_network_link" "this" {
  for_each = var.vnets

  name                      = "link-${each.key}"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  virtual_network_id        = each.value
}
