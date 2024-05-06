resource "azurerm_policy_set_definition" "this" {
  display_name        = local.initiative_definition.display_name
  description         = local.initiative_definition.description
  management_group_id = "/providers/Microsoft.Management/managementGroups/8d088ff8-7e52-4d0f-8187-dcd9ca37815a"
  name                = local.initiative_definition.name
  policy_type         = "Custom"

  dynamic "policy_definition_reference" {
    for_each = {
      for k, v in local.all_policies :
      k => v if v.parameters != null
    }
    content {
      policy_definition_id = policy_definition_reference.value.id
      parameter_values     = jsonencode(local.policies[policy_definition_reference.key].parameters)
    }
  }
}
