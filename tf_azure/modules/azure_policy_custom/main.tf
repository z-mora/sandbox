resource "azurerm_policy_definition" "custom_policies" {
  for_each = {
    for k, v in local.policies :
    k => jsondecode(file("${path.root}/policies/${v.file}")) if v.type == "Custom"
  }

  description         = each.value.properties.description
  display_name        = each.value.properties.displayName
  management_group_id = "/providers/Microsoft.Management/managementGroups/8d088ff8-7e52-4d0f-8187-dcd9ca37815a" #tenant root group
  metadata            = jsonencode(each.value.properties.metadata)
  mode                = each.value.properties.mode
  name                = each.key
  parameters          = jsonencode(each.value.properties.parameters)
  policy_rule         = jsonencode(each.value.properties.policyRule)
  policy_type         = each.value.properties.policyType
}
