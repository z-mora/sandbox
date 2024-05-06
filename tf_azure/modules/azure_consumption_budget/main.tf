resource "azurerm_consumption_budget_subscription" "this" {
  count = var.type == "sub" ? 1 : 0

  amount          = var.amount
  name            = var.consumption_budget_name
  subscription_id = data.azurerm_subscription.current.id
  time_grain      = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "filter" {
    for_each = local.create_budget_filter ? [1] : []
    content {
      dynamic "dimension" {
        for_each = var.dimensions
        content {
          name     = dimension.value["name"]
          operator = dimension.value["operator"]
          values   = dimension.value["values"]
        }
      }

      dynamic "tag" {
        for_each = var.tags
        content {
          name     = tag.value["name"]
          operator = tag.value["operator"]
          values   = tag.value["values"]
        }
      }
    }
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      contact_emails = notification.value["contact_emails"]
      contact_groups = notification.value["contact_groups"]
      contact_roles  = notification.value["contact_roles"]
      enabled        = notification.value["enabled"]
      operator       = notification.value["operator"]
      threshold      = notification.value["threshold"]
      threshold_type = notification.value["threshold_type"]
    }
  }
}

resource "azurerm_consumption_budget_management_group" "this" {
  count = var.type == "mg" ? 1 : 0

  amount              = var.amount
  management_group_id = data.azurerm_management_group.this[0].id
  name                = var.consumption_budget_name
  time_grain          = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "filter" {
    for_each = local.create_budget_filter ? [1] : []
    content {
      dynamic "dimension" {
        for_each = var.dimensions
        content {
          name     = dimension.value["name"]
          operator = dimension.value["operator"]
          values   = dimension.value["values"]
        }
      }

      dynamic "tag" {
        for_each = var.tags
        content {
          name     = tag.value["name"]
          operator = tag.value["operator"]
          values   = tag.value["values"]
        }
      }
    }
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      contact_emails = notification.value["contact_emails"]
      enabled        = notification.value["enabled"]
      operator       = notification.value["operator"]
      threshold      = notification.value["threshold"]
      threshold_type = notification.value["threshold_type"]
    }
  }
}

resource "azurerm_consumption_budget_resource_group" "this" {
  count = var.type == "rg" ? 1 : 0

  amount            = var.amount
  name              = var.consumption_budget_name
  resource_group_id = data.azurerm_resource_group.this[0].id
  time_grain        = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "filter" {
    for_each = local.create_budget_filter ? [1] : []
    content {
      dynamic "dimension" {
        for_each = var.dimensions
        content {
          name     = dimension.value["name"]
          values   = dimension.value["values"]
          operator = dimension.value["operator"]
        }
      }

      dynamic "tag" {
        for_each = var.tags
        content {
          name     = tag.value["name"]
          operator = tag.value["operator"]
          values   = tag.value["values"]
        }
      }
    }
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      contact_emails = notification.value["contact_emails"]
      contact_groups = notification.value["contact_groups"]
      contact_roles  = notification.value["contact_roles"]
      enabled        = notification.value["enabled"]
      operator       = notification.value["operator"]
      threshold      = notification.value["threshold"]
      threshold_type = notification.value["threshold_type"]
    }
  }
}
