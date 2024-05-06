# storage_accounts = {
#   "samikentest" = {
#     account_replication_type = "LRS"
#     account_tier             = "Standard"
#     location = "eastus2"
#     private_endpoints = {
#       pep-samikentest-blob = {
#         subnet = {
#           name = "subnet-dmz-infraops-dev-01"
#           resource_group_name = "rg-infraops-dev-01"
#           virtual_network_name = "vnet-dmz-infraops-dev-eastus2"
#         }
#         subresource_name = "blob"
#       }
#     }
#     resource_group_name           = "rg-infraops-dev-01"
#   }
# }
