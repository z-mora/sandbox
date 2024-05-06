resource "azurerm_virtual_network" "this" {
  address_space       = var.cidr
  dns_servers         = var.dns_servers == null ? local.default_dns_servers : var.dns_servers
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.required_tags

  lifecycle {
    ignore_changes = [tags["NMW_OBJECT_TYPE"]]
  }
}

resource "azurerm_subnet" "private" {
  for_each = var.private_subnets

  address_prefixes                              = each.value.address_prefixes
  name                                          = each.key
  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  resource_group_name                           = var.resource_group_name
  service_endpoints                             = coalesce(each.value.service_endpoints, local.service_endpoints)
  virtual_network_name                          = azurerm_virtual_network.this.name

  dynamic "delegation" {
    for_each = each.value.delegation_name != null ? [1] : []
    content {
      name = each.value.delegation_name
      service_delegation {
        actions = each.value.delegation_actions
        name    = each.value.delegation_service
      }
    }
  }
}

resource "azurerm_subnet" "gateway" {
  count = var.gateway_subnet_address_prefix == null ? 0 : 1

  address_prefixes     = var.gateway_subnet_address_prefix
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  lifecycle {
    ignore_changes = [delegation]
  }
}

resource "azurerm_subnet_network_security_group_association" "private_subnet" {
  for_each = var.private_subnets

  network_security_group_id = each.value.network_security_group_id
  subnet_id                 = azurerm_subnet.private[each.key].id
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = { for k, v in var.private_subnets : k => v if v.route_table_key != null }

  route_table_id = each.value.route_table_id
  subnet_id      = azurerm_subnet.private[each.key].id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  eventhub_authorization_rule_id = var.monitor_diagnostic_destinations.eventhubs[var.location].authorization_rule_id
  eventhub_name                  = var.monitor_diagnostic_destinations.eventhubs[var.location].eventhub_name
  log_analytics_workspace_id     = var.monitor_diagnostic_destinations.log_analytics_workspace_id
  name                           = "diag-${var.name}-activity-logs"
  target_resource_id             = azurerm_virtual_network.this.id

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
      enabled  = true
    }
  }
}
