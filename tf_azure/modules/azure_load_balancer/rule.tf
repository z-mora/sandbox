resource "azurerm_lb_rule" "load_balancer_rules" {
  for_each = var.load_balancer_rules

  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.load_balancer_backend_pool.id]
  backend_port                   = each.value.backend_port
  disable_outbound_snat          = each.value.disable_outbound_snat
  enable_floating_ip             = each.value.enable_floating_ip
  enable_tcp_reset               = each.value.enable_tcp_reset
  frontend_ip_configuration_name = var.frontend_name
  frontend_port                  = each.value.frontend_port
  idle_timeout_in_minutes        = each.value.idle_timeout
  load_distribution              = each.value.load_distribution
  loadbalancer_id                = azurerm_lb.load_balancers.id
  name                           = each.key
  probe_id                       = azurerm_lb_probe.load_balancer_probes[each.key].id
  protocol                       = each.value.protocol
}

resource "azurerm_lb_probe" "load_balancer_probes" {
  for_each = var.load_balancer_rules

  interval_in_seconds = each.value.probe_interval
  loadbalancer_id     = azurerm_lb.load_balancers.id
  name                = each.value.probe_name
  number_of_probes    = each.value.probe_number
  port                = each.value.probe_port
  protocol            = each.value.probe_protocol
  request_path        = each.value.probe_protocol == "Tcp" ? null : each.value.probe_request_path
}
