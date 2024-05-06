locals {
  all_policies          = merge(azurerm_policy_definition.custom_policies, data.azurerm_policy_definition.built_in)
  initiative_definition = yamldecode(file("${path.root}/policies/${var.initiative_definition_name}/initiative_definition.yaml"))
  policies = {
    for name, policy in local.initiative_definition.policies : name => policy
  }
}
