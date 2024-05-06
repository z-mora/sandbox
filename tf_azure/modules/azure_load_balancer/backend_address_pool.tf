resource "azurerm_lb_backend_address_pool" "load_balancer_backend_pool" {
  loadbalancer_id = azurerm_lb.load_balancers.id
  name            = var.backend_pool_name
}

resource "azurerm_lb_backend_address_pool_address" "load_balancer_backend_pool_address" {
  for_each = var.backend_pool_addresses

  backend_address_pool_id = azurerm_lb_backend_address_pool.load_balancer_backend_pool.id
  ip_address              = each.value.backend_ip_address
  name                    = each.value.backend_pool_address_name
  virtual_network_id      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}"
}
