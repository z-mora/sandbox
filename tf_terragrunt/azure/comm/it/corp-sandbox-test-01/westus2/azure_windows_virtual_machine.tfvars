# windows_virtual_machines = {
#   "testmachine" = {
#     backup = {
#       policy_key = "test-backup-policy"
#       rsv_key    = "rsv-sandbox-test-westus2"
#     }
#     key_vault_key = "kv-sandbox-test-westus2"
#     disk_size_gb  = "127"
#     domain_join   = false
#     location      = "westus2"
#     managed_disks = {
#       "testmachine-disk2" = {
#         create_option        = "Empty"
#         disk_size_gb         = 50
#         lun                  = 10
#         storage_account_type = "Premium_LRS"
#         tier                 = "P10"
#         zone                 = 1
#       }
#     }
#     network_interfaces = {
#       "testmachine-network-interface1" = {
#         enable_accelerated_networking = false
#         enable_ip_forwarding          = false
#         private_ip_address_allocation = "Dynamic"
#         subnet_key                    = "subnet-sandbox-test-01"
#       }
#     }
#     resource_group_name  = "rg-sandbox-test-westus2"
#     size                 = "Standard_B2s"
#     sku                  = "2019-datacenter-gensecond"
#     storage_account_type = "Premium_LRS"
#     timezone             = "Central Standard Time"
#     virtual_network      = "vnet-sandbox-test-westus2"
#     zone                 = 1
#   }
# }

