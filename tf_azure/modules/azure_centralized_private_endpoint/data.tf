data "azurerm_subnet" "private_endpoint_hub" {
  name                 = "subnet-internal-private-endpoint-hub-${var.location}-prod-01"
  resource_group_name  = "rg-private-endpoint-hub-prod-01"
  virtual_network_name = "vnet-internal-private-endpoint-hub-${var.location}-prod-01"
}
