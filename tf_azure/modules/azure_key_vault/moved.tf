moved {
  from = azurerm_key_vault.key_vault
  to   = azurerm_key_vault.this
}

moved {
  from = azurerm_role_assignment.keyvault
  to   = azurerm_role_assignment.key_vault_admin["0652ef60-f369-4dd0-ac3d-13f639d3baf8"]
}
