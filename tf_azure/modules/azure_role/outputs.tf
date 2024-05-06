output "id" {
  description = <<-DESCRIPTION
  The Terraform-specific ID of the role. THe format is `{roleDefinitionId}|{scope}`.
  This is only used by the `azure_role_assignment` module to create an implicit
  dependency.
  DESCRIPTION
  value       = azurerm_role_definition.this.id
}
