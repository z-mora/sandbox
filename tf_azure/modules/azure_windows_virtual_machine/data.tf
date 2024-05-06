data "azurerm_key_vault_secret" "domain_pass" {
  count = var.domain_join ? 1 : 0

  name         = "ParsonscomPassword"
  key_vault_id = data.azurerm_key_vault.domain_key_vault[0].id
}

data "azurerm_key_vault_secret" "domain_user" {
  count = var.domain_join ? 1 : 0

  name         = "ParsonscomUsername"
  key_vault_id = data.azurerm_key_vault.domain_key_vault[0].id
}

data "azurerm_key_vault" "domain_key_vault" {
  count = var.domain_join ? 1 : 0

  name                = "DomainJoinVault"
  resource_group_name = var.resource_group_name
}
