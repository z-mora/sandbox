resource "azurerm_private_dns_resolver" "this" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.required_tags
  virtual_network_id  = var.virtual_network_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  location                = var.location
  name                    = "in-${var.name}"
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  tags                    = var.required_tags

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.inbound_subnet_id
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  location                = var.location
  name                    = "out-${var.name}"
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.outbound_subnet_id
  tags                    = var.required_tags
}
