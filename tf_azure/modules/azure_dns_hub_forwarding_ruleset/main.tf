resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  location                                   = var.location
  name                                       = var.name
  private_dns_resolver_outbound_endpoint_ids = [var.outbound_endpoint_id]
  resource_group_name                        = var.resource_group_name
  tags                                       = var.required_tags
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  for_each = var.private_link_zone_names

  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  domain_name               = "${each.value}."
  enabled                   = true
  # '.' isn't a valid character in a rule name, replace with '_'
  name = replace(each.value, ".", "_")

  target_dns_servers {
    ip_address = var.inbound_endpoint_ip
    port       = 53
  }
}

resource "azurerm_private_dns_resolver_forwarding_rule" "custom" {
  for_each = var.custom_rules

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
