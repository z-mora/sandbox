# recovery_services_vaults = {
#   "rsv-sandbox-test-westus2" = {
#     location                      = "westus2"
#     sku                           = "Standard"
#     soft_delete_enabled           = false
#     public_network_access_enabled = false
#     resource_group_name           = "rg-sandbox-test-westus2"
#     backup_policies = {
#       "test-backup-policy" = {
#         resource_group_name = "rg-sandbox-test-westus2"
#         backup = {
#           frequency = "Daily"
#           time      = "23:00"
#         }
#         retention_daily = {
#           count = 10
#         }
#         retention_weekly = {
#           count    = 1
#           weekdays = ["Sunday"]
#         }
#         retention_monthly = {
#           count    = 7
#           weekdays = ["Sunday", "Wednesday"]
#           weeks    = ["First", "Last"]
#         }
#         retention_yearly = {
#           count    = 77
#           weekdays = ["Sunday"]
#           weeks    = ["Last"]
#           months   = ["January"]
#         }
#       }
#     }
#   }
# }
