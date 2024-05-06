resource "azurerm_public_ip" "load_balancer_public_ip" {
  count = local.is_external ? 1 : 0

  allocation_method   = "Static"
  ip_version          = "IPv4"
  location            = var.location
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  sku                 = var.sku # Options are Basic and Standard
  sku_tier            = "Regional"
  tags                = var.required_tags
}

resource "azurerm_lb" "load_balancers" {
  location            = var.location
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
  sku                 = var.sku # Options are Basic, Standard and Gateway
  sku_tier            = "Regional"
  tags                = var.required_tags

  frontend_ip_configuration {
    name                          = var.frontend_name
    private_ip_address_allocation = local.is_external ? null : "Dynamic"
    private_ip_address_version    = local.is_external ? null : "IPv4"
    public_ip_address_id = (
      local.is_external ? azurerm_public_ip.load_balancer_public_ip[0].id : null
    )
    subnet_id = (
      local.is_external ? null :
      "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.frontend_subnet}"
    )
    zones = var.zones
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  eventhub_authorization_rule_id = var.monitor_diagnostic_destinations.eventhubs[var.location].authorization_rule_id
  eventhub_name                  = var.monitor_diagnostic_destinations.eventhubs[var.location].eventhub_name
  log_analytics_workspace_id     = var.monitor_diagnostic_destinations.log_analytics_workspace_id
  name                           = "diag-${var.load_balancer_name}-activity-logs"
  target_resource_id             = azurerm_lb.load_balancers.id
  ##log_analytics_destination_type = var.diag_destination_type "unsure if we use this"

  dynamic "enabled_log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.this.log_category_types)
    content {
      category = enabled_log.key
    }
  }

  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.this.metrics)
    content {
      category = metric.key
      enabled  = true # Create other Modules if you don't want them all on, by default
    }
  }
}
