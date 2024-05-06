moved {
  from = azurerm_network_security_group.network_security_groups
  to   = azurerm_network_security_group.this
}

moved {
  from = azurerm_network_security_rule.network_security_group_rules
  to   = azurerm_network_security_rule.this
}
