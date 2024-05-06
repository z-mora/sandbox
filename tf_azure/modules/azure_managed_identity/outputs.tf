output "client_id" {
  description = "The ID of the app associated with the Identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "id" {
  description = "The ID of the user-assigned managed identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "principal_id" {
  description = "The ID of the service principal associated with the identity."
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "tenant_id" {
  description = "The ID of the tenant which the identity belongs to."
  value       = azurerm_user_assigned_identity.this.tenant_id
}
