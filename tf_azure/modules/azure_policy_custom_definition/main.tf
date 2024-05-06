resource "azurerm_policy_definition" "this" {
  name                = var.name
  policy_type         = "Custom"
  mode                = var.mode
  display_name        = var.display_name
  description         = var.description
  policy_rule         = var.policy_rule
  management_group_id = data.azurerm_management_group.this.id
  # Azure adds a few values to the metadata automatically, this causes terraform to detect drift
  # this drift is not detected if we add anything to the metadata so to ensure the drift is 
  # ignored we add an owner key/value to the metadata
  metadata   = jsonencode(merge(var.metadata, { "Owner" = "Parsons" }))
  parameters = try(jsonencode(var.parameters), null)

  lifecycle {
    #Ignoreing parameters due to Azure policy not apply null values within this object
    #this causes drift to be detected indefinitely due to Terraform wanting to apply
    #null values
    ignore_changes = [parameters]
  }
}
