resource "azurerm_managed_disk" "this" {
  for_each = var.managed_disks

  create_option          = each.value.create_option
  disk_encryption_set_id = azurerm_disk_encryption_set.rsa_encryption.id
  disk_size_gb           = each.value.disk_size_gb
  location               = var.location
  name                   = each.key
  resource_group_name    = var.resource_group_name
  storage_account_type   = each.value.storage_account_type
  tags                   = merge(var.required_tags, { Name = each.key })
  tier                   = each.value.tier
  zone                   = each.value.zone

  depends_on = [azurerm_role_assignment.disk_set_permissions]
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each = var.managed_disks

  caching            = "ReadWrite"
  lun                = each.value.lun
  managed_disk_id    = azurerm_managed_disk.this[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
}
