resource "azurerm_private_endpoint" "this" {
  custom_network_interface_name = "nic-${var.name}"
  name                          = var.name
  location                      = var.location
  resource_group_name           = "rg-private-endpoint-hub-prod-01"
  subnet_id                     = data.azurerm_subnet.private_endpoint_hub.id
  tags                          = var.required_tags

  private_service_connection {
    is_manual_connection           = false
    name                           = var.name
    private_connection_resource_id = var.resource_id
    subresource_names              = var.subresource_names
  }

  lifecycle {
    # private_dns_zone_group gets configured automatically by Azure Policy
    ignore_changes = [private_dns_zone_group]
  }
}
