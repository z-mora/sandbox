resource "azurerm_resource_group" "networkwatcher" {
  name     = "NetworkWatcherRG"
  location = var.is_gov ? "usgovvirginia" : "eastus2"
}


resource "azurerm_network_watcher" "this" {
  for_each = var.is_gov ? toset(local.gov_regions) : toset(local.comm_regions)

  name                = "NetworkWatcher_${each.value}"
  location            = each.value
  resource_group_name = azurerm_resource_group.networkwatcher.name
}
