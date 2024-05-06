
resource "azurerm_policy_definition" "this" {
  for_each     = var.policy_definition
  name         = each.key
  description  = each.value.description
  display_name = each.value.display_name
  mode         = each.value.mode
  policy_type  = each.value.policy_type
  parameters   = jsonencode(each.value.parameters)
  metadata     = jsonencode(each.value.metadata)
  policy_rule  = jsonencode(each.value.policy_rule)
}
