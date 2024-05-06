data "azurerm_private_dns_resolver" "this" {
  name                = "dnspr-prod-${var.location}-01"
  resource_group_name = "rg-dns-prod-01"
}

data "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = "out-${data.azurerm_private_dns_resolver.this.name}"
  private_dns_resolver_id = data.azurerm_private_dns_resolver.this.id
}
