resource "azurerm_disk_encryption_set" "rsa_encryption" {
  key_vault_key_id    = azurerm_key_vault_key.disk_key.id
  location            = var.location
  name                = "des-${var.virtual_machine_name}"
  resource_group_name = var.resource_group_name
  tags                = var.required_tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_key" "disk_key" {
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  key_size     = 2048
  key_type     = "RSA"
  key_vault_id = var.key_vault_id
  name         = var.virtual_machine_name
  tags         = var.required_tags
}

resource "azurerm_role_assignment" "disk_set_permissions" {
  principal_id         = azurerm_disk_encryption_set.rsa_encryption.identity[0].principal_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  scope                = var.key_vault_id
}
