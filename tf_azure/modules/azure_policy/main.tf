
resource "azurerm_resource_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "r"
  }

  enforce              = each.value.enforce
  policy_definition_id = each.value.policy_definition_id
  name                 = each.key
  description          = each.value.description
  resource_id          = each.value.scope_id
  parameters           = each.value.parameters
  metadata             = each.value.metadata
  location             = each.value.location
  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}

resource "azurerm_resource_group_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "rg"
  }

  enforce              = each.value.enforce
  policy_definition_id = each.value.policy_definition_id
  name                 = each.key
  description          = each.value.description
  resource_group_id    = each.value.scope_id
  parameters           = each.value.parameters
  metadata             = each.value.metadata
  location             = each.value.location
  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}

resource "azurerm_subscription_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "sub"
  }

  enforce              = each.value.enforce
  policy_definition_id = each.value.policy_definition_id
  name                 = each.key
  description          = each.value.description
  subscription_id      = each.value.scope_id
  parameters           = each.value.parameters
  metadata             = each.value.metadata
  location             = each.value.location
  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}

resource "azurerm_management_group_policy_assignment" "this" {
  for_each = {
    for name, assignment in var.built_in_assignments :
    name => assignment if assignment.scope == "mg"
  }

  enforce              = each.value.enforce
  policy_definition_id = each.value.policy_definition_id
  management_group_id  = each.value.scope_id
  name                 = each.key
  description          = each.value.description
  parameters           = each.value.parameters
  metadata             = each.value.metadata
  location             = each.value.location
  identity {
    type         = each.value.identity_type
    identity_ids = each.value.identity_ids
  }
}
