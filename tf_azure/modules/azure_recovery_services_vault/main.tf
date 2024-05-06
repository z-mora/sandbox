resource "azurerm_recovery_services_vault" "this" {
  location                      = var.location
  name                          = var.name
  public_network_access_enabled = var.public_network_access_enabled
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  soft_delete_enabled           = var.soft_delete_enabled
  tags                          = var.required_tags
}

resource "azurerm_backup_policy_vm" "this" {
  for_each = var.backup_policies

  name                = each.key
  resource_group_name = each.value.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name

  backup {
    frequency = each.value.backup.frequency
    time      = each.value.backup.time
  }

  dynamic "retention_daily" {
    for_each = local.backup_policies_retention_periods[each.key].retention_daily_exists ? [1] : []
    content {
      count = each.value.retention_daily.count
    }
  }

  dynamic "retention_weekly" {
    for_each = local.backup_policies_retention_periods[each.key].retention_weekly_exists ? [1] : []
    content {
      count    = each.value.retention_weekly.count
      weekdays = each.value.retention_weekly.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = local.backup_policies_retention_periods[each.key].retention_monthly_exists ? [1] : []
    content {
      count    = each.value.retention_monthly.count
      weekdays = each.value.retention_monthly.weekdays
      weeks    = each.value.retention_monthly.weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = local.backup_policies_retention_periods[each.key].retention_yearly_exists ? [1] : []
    content {
      count    = each.value.retention_yearly.count
      months   = each.value.retention_yearly.months
      weekdays = each.value.retention_yearly.weekdays
      weeks    = each.value.retention_yearly.weeks
    }
  }
}

resource "azurerm_backup_policy_vm_workload" "this" {
  for_each = var.backup_policies_workloads

  name                = each.key
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  resource_group_name = each.value.resource_group_name
  workload_type       = each.value.workload_type

  settings {
    compression_enabled = each.value.settings.compression_enabled
    time_zone           = each.value.settings.time_zone
  }

  dynamic "protection_policy" {
    for_each = each.value.protection_policies
    content {
      policy_type = protection_policy.value["policy_type"]

      backup {
        frequency = protection_policy.value["backup"].frequency
        time      = protection_policy.value["backup"].time
      }

      dynamic "retention_daily" {
        for_each = protection_policy.value.retention_daily
        content {
          count = retention_daily.value
        }
      }
    }
  }
}
