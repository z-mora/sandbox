output "backup_policies" {
  description = "A map of all backup policies that were created"
  value       = azurerm_backup_policy_vm.this
}

output "id" {
  description = "The ID of the recovery services vault that was created"
  value       = azurerm_recovery_services_vault.this.id
}

output "name" {
  description = "The name of the recovery services vault that was created"
  value       = azurerm_recovery_services_vault.this.name
}
