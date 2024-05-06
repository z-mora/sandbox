resource "azurerm_eventhub_namespace" "eventhub_namespaces" {
  auto_inflate_enabled          = var.auto_inflate_enabled
  capacity                      = var.capacity
  location                      = var.location
  maximum_throughput_units      = var.auto_inflate_enabled ? var.maximum_throughput_units : null
  name                          = var.eventhub_namespace_name
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  tags                          = var.required_tags
  public_network_access_enabled = var.public_network_access_enabled
}

resource "azurerm_eventhub" "eventhub" {
  for_each = var.eventhubs

  message_retention   = each.value.message_retention
  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespaces.name
  partition_count     = each.value.partition_count
  resource_group_name = var.resource_group_name
}
