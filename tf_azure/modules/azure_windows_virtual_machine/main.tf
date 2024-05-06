resource "azurerm_network_interface" "this" {
  for_each = var.network_interfaces

  enable_ip_forwarding          = each.value.enable_ip_forwarding
  enable_accelerated_networking = each.value.enable_accelerated_networking
  location                      = var.location
  name                          = each.key
  resource_group_name           = var.resource_group_name
  tags                          = merge(var.required_tags, { Name = each.key })

  ip_configuration {
    name                          = each.key
    private_ip_address_allocation = each.value.private_ip_address_allocation
    subnet_id                     = var.private_subnets[each.value.subnet_key].id
  }
}

# Generate an initial local admin password
# BeyondTrust will change this immediately upon AD join
resource "random_password" "admin" {
  length = 16
}

resource "azurerm_windows_virtual_machine" "this" {
  admin_password        = random_password.admin.result
  admin_username        = "par_admin"
  custom_data           = var.domain_join ? var.domain_join_build_script : null
  location              = var.location
  name                  = var.virtual_machine_name
  network_interface_ids = [for i in azurerm_network_interface.this : i.id]
  resource_group_name   = var.resource_group_name
  size                  = var.size
  tags                  = merge(var.required_tags, { Name = var.virtual_machine_name })
  timezone              = var.timezone
  zone                  = var.zone

  boot_diagnostics {} # Diagnostics get stored in a managed storage account

  os_disk {
    caching                = "ReadWrite"
    disk_encryption_set_id = azurerm_disk_encryption_set.rsa_encryption.id
    disk_size_gb           = var.disk_size_gb
    storage_account_type   = var.storage_account_type
  }

  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = var.sku
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [admin_password]
  }

  depends_on = [azurerm_role_assignment.disk_set_permissions]
}

resource "azurerm_virtual_machine_extension" "domain_join" {
  count = var.domain_join ? 1 : 0

  name                 = "build_script"
  publisher            = "Microsoft.Compute"
  settings             = <<SETTINGS
  {
      "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/build_script.ps1; c:/azuredata/build_script.ps1 -user \"${data.azurerm_key_vault_secret.domain_user[0].value}\" -pass '${data.azurerm_key_vault_secret.domain_pass[0].value}' \""
  }
  SETTINGS
  tags                 = var.required_tags
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
}

resource "azurerm_backup_protected_vm" "this" {
  count = var.backup == null ? 0 : 1

  backup_policy_id    = var.backup.policy_id
  recovery_vault_name = var.backup.recovery_vault_name
  resource_group_name = var.resource_group_name
  source_vm_id        = azurerm_windows_virtual_machine.this.id
}
