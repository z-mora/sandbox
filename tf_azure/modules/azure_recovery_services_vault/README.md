<!-- BEGIN_TF_DOCS -->
# azure_recovery_services_vault

This module allows you to create a recovery services vault with backup policies.

## Additional Info

* [Recovery Services vaults overview](https://learn.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview)
* [azurerm_recovery_services_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault.html)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_policies"></a> [backup\_policies](#input\_backup\_policies) | map of backup policies | <pre>map(object({<br>    backup = object({<br>      frequency = string<br>      time      = string<br>    })<br>    resource_group_name = string<br>    retention_daily = object({<br>      count = number<br>    })<br>    retention_monthly = object({<br>      count    = number<br>      weekdays = list(string)<br>      weeks    = list(string)<br>    })<br>    retention_weekly = object({<br>      count    = number<br>      weekdays = list(string)<br>    })<br>    retention_yearly = object({<br>      count    = number<br>      months   = list(string)<br>      weekdays = list(string)<br>      weeks    = list(string)<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_backup_policies_workloads"></a> [backup\_policies\_workloads](#input\_backup\_policies\_workloads) | backup policies for non-VM workloads | <pre>map(object({<br>    protection_policies = map(object({<br>      backup = object({<br>        frequency = string<br>        time      = string<br>      })<br>      policy_type = string<br>      retention_daily = object({<br>        count = number<br>      })<br>    }))<br>    resource_group_name = string<br>    settings = object({<br>      time_zone           = string<br>      compression_enabled = bool<br>    })<br>    workload_type = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"eastus2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Recovery Services Vault | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | enabled public network access to the Recovery services vaults | `bool` | `false` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "BACKUP")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group the Recovery services vault will go in | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | sku of the Recovery Services Vault | `string` | n/a | yes |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | Turn on soft delete for the backups created (keeps for 14 days after deletion) | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_policies"></a> [backup\_policies](#output\_backup\_policies) | A map of all backup policies that were created |
| <a name="output_id"></a> [id](#output\_id) | The ID of the recovery services vault that was created |
| <a name="output_name"></a> [name](#output\_name) | The name of the recovery services vault that was created |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_policy_vm_workload.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm_workload) | resource |
| [azurerm_recovery_services_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |

## Examples

```hcl
# Example 1
recovery_services_vaults = {
  "recovery-services-vault-test" = {
    backup_policies = {
      "test-backup-policy" = {
        backup = {
          frequency = "Daily"
          time      = "23:00"
        }
        resource_group_name = "rg-cps-prod-01"
        retention_daily = {
          count = 10
        }
        retention_monthly = {
          count    = 7
          weekdays = ["Sunday", "Wednesday"]
          weeks    = ["First", "Last"]
        }
        retention_weekly = {
          count    = 1
          weekdays = ["Sunday"]
        }
        retention_yearly = {
          count    = 77
          months   = ["January"]
          weekdays = ["Sunday"]
          weeks    = ["Last"]
        }
      }
    }
    backup_policies_workloads = {
      "test-backup-workload-policy" = {
        protection_policies = {
          "test-protection-policy" = {
            backup = {
              frequency = "Daily"
              time      = "15:00"
            }
            policy_type = "Full"
            retention_daily = {
              count = 8
            }
          }
        }
        resource_group_name = "rg-cps-prod-01"
        settings = {
          compression_enabled = false
          time_zone           = "UTC"
        }
        workload_type       = "SQLDataBase"
      }
    }
    location                      = "eastus2"
    public_network_access_enabled = false
    resource_group_name           = "rg-cps-prod-01"
    sku                           = "Standard"
    soft_delete_enabled           = true
  }
}
```
<!-- END_TF_DOCS -->