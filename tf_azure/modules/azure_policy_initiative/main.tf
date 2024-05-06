resource "azurerm_policy_set_definition" "this" {
  description         = var.description
  display_name        = var.display_name
  management_group_id = try(data.azurerm_management_group.initiative_destination[0].id, null)
  metadata            = var.metadata == null ? null : jsonencode(var.metadata)
  name                = var.name
  parameters          = var.parameters == null ? null : jsonencode(var.parameters)
  policy_type         = "Custom"

  dynamic "policy_definition_group" {
    for_each = var.policy_definition_groups
    content {
      category     = policy_definition_group.value.category
      description  = policy_definition_group.value.description
      display_name = coalesce(policy_definition_group.value.display_name, policy_definition_group.key)
      name         = policy_definition_group.key
    }
  }

  dynamic "policy_definition_reference" {
    for_each = var.policy_definition_references
    content {
      parameter_values = jsonencode({
        for k, v in policy_definition_reference.value.parameters : k => {
          # The values returned by a conditional expression must be of the same type,
          # which is why we create a tuple and use the conditional expression to select
          # the correct index
          value = [v.string_value, v.list_value][v.list_value == null ? 0 : 1]
        }
      })
      policy_definition_id = data.azurerm_policy_definition.this[policy_definition_reference.key].id
      policy_group_names   = policy_definition_reference.value.policy_group_names
      # Set reference_id so the same policy can be added more than once. Map keys must
      # be unique, so use the hash of that value
      reference_id = md5(policy_definition_reference.key)
    }
  }
}

resource "azurerm_management_group_policy_assignment" "this" {
  for_each = { for k, v in var.assignments : k => v if v.scope_type == "management_group" }

  display_name         = "${var.name} (management group: ${each.key})"
  location             = each.value.location
  management_group_id  = data.azurerm_management_group.assignment[each.key].id
  name                 = each.key
  policy_definition_id = azurerm_policy_set_definition.this.id

  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [0]
    content {
      identity_ids = (
        length(each.value.identity.identity_ids) > 0 ?
        each.value.identity.identity_ids : null
      )
      type = each.value.identity.type
    }
  }
}

resource "azurerm_subscription_policy_assignment" "this" {
  for_each = { for k, v in var.assignments : k => v if v.scope_type == "subscription" }

  display_name         = "${var.name} (subscription: ${each.key})"
  location             = each.value.location
  name                 = each.key
  policy_definition_id = azurerm_policy_set_definition.this.id
  subscription_id      = data.azurerm_subscriptions.this[each.key].subscriptions[0].id

  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [0]
    content {
      identity_ids = (
        length(each.value.identity.identity_ids) > 0 ?
        each.value.identity.identity_ids : null
      )
      type = each.value.identity.type
    }
  }
}

resource "azurerm_management_group_policy_exemption" "this" {
  for_each = { for k, v in local.exemptions : k => v if v.scope_type == "management_group" }

  description          = each.value.description
  display_name         = each.value.display_name
  exemption_category   = each.value.category
  management_group_id  = data.azurerm_management_group.exemption[each.key].id
  name                 = each.value.scope_display_name
  policy_assignment_id = each.value.policy_assignment_id
}

resource "azurerm_subscription_policy_exemption" "this" {
  for_each = { for k, v in local.exemptions : k => v if v.scope_type == "subscription" }

  description          = each.value.description
  display_name         = each.value.display_name
  exemption_category   = each.value.category
  name                 = each.value.scope_display_name
  policy_assignment_id = each.value.policy_assignment_id
  subscription_id      = data.azurerm_subscriptions.exemption[each.key].subscriptions[0].id
}
