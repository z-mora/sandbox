/* recovery_services_vaults = {
  "recovery-services-vault-test" = {
    sku                           = "Standard"
    soft_delete_enabled           = true
    public_network_access_enabled = false
    resource_group_name           = "rg-cps-prod-01"
    backup_policies = {
      "test-backup-policy" = {
        resource_group_name = "rg-cps-prod-01"
        backup = {
          frequency = "Daily"
          time      = "23:00"
        }
        retention_daily = {
          count = 10
        }
        retention_weekly = {
          count    = 1
          weekdays = ["Sunday"]
        }
        retention_monthly = {
          count    = 7
          weekdays = ["Sunday", "Wednesday"]
          weeks    = ["First", "Last"]
        }

        retention_yearly = {
          count    = 77
          weekdays = ["Sunday"]
          weeks    = ["Last"]
          months   = ["January"]
        }
      }
    }
    backup_policies_workloads = {
      "test-backup-workload-policy" = {
        resource_group_name = "rg-cps-prod-01"
        workload_type       = "SQLDataBase"
        settings = {
          time_zone           = "UTC"
          compression_enabled = false
        }
        protection_policies = {
          "test-protection-policy" = {
            policy_type = "Full"
            backup = {
              frequency = "Daily"
              time      = "15:00"
            }
            retention_daily = {
              count = 8
            }
          }
        }
      }
    }
  }
}
 */
