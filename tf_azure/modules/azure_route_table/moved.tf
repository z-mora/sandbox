moved {
  from = azurerm_route_table.route_table
  to   = azurerm_route_table.this
}

moved {
  from = azurerm_route.route
  to   = azurerm_route.this
}

moved {
  from = azurerm_subnet_route_table_association.subnet_route_table_association
  to   = azurerm_subnet_route_table_association.this
}
