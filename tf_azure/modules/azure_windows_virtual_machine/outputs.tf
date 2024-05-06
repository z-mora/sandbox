output "id" {
  description = "The ID of the Windows VM"
  value       = azurerm_windows_virtual_machine.this.id
}

output "initial_admin_password" {
  description = <<EOL
  The initial admin password for the VM for the par_admin local user. If you join this
  VM to the domain, this password will no longer be valid as it will be changed and
  managed by BeyondTrust.
  EOL
  sensitive   = true
  value       = random_password.admin.result
}

output "private_ip_address" {
  description = "The primary private IP assigned to the Windows VM"
  value       = azurerm_windows_virtual_machine.this.private_ip_address
}

output "private_ip_addresses" {
  description = "A list of private IPs assigned to the Windows VM"
  value       = azurerm_windows_virtual_machine.this.private_ip_addresses
}
