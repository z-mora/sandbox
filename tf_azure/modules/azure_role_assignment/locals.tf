locals {
  scope = try(
    data.azurerm_management_group.scope[0].id,
    data.azurerm_resource_group.scope[0].id,
    data.azurerm_subscriptions.scope[0].subscriptions[0].id,
    var.scope.id
  )
}
