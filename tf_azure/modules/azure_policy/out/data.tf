data "azurerm_policy_definition" "built_in" {
  for_each = {
    for k, v in local.policies :
    k => v if v.type == "BuiltIn"
  }

  name = each.value.id
}
