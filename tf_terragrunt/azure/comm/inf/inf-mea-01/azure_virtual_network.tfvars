# virtual_networks = {
#   "vnet-dmz-inet-iac-integration-dev-01" = {
#     cidr     = ["10.212.56.0/22"]
#     is_dmz   = true
#     location = "eastus2"
#     private_subnets = {
#       "subnet-dmz-inet-iac-integration-dev-01" = {
#         address_prefixes           = ["10.212.56.0/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-02" = {
#         address_prefixes           = ["10.212.56.64/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-03" = {
#         address_prefixes           = ["10.212.56.128/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-04" = {
#         address_prefixes           = ["10.212.56.192/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-05" = {
#         address_prefixes           = ["10.212.57.0/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-06" = {
#         address_prefixes           = ["10.212.57.64/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-07" = {
#         address_prefixes           = ["10.212.57.128/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-08" = {
#         address_prefixes           = ["10.212.57.192/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-09" = {
#         address_prefixes           = ["10.212.58.0/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-10" = {
#         address_prefixes           = ["10.212.58.64/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-11" = {
#         address_prefixes           = ["10.212.58.128/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-12" = {
#         address_prefixes           = ["10.212.58.192/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-13" = {
#         address_prefixes           = ["10.212.59.0/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "subnet-dmz-inet-iac-integration-dev-14" = {
#         address_prefixes           = ["10.212.59.64/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-01"
#       }
#       "AzureBastionSubnet" = {
#         address_prefixes           = ["10.212.59.128/26"]
#         network_security_group_key = "nsg-bastion-01"
#         service_endpoints          = []
#       }
#       "subnet-dmz-inet-iac-integration-dev-appgw-01" = {
#         address_prefixes           = ["10.212.59.192/26"]
#         network_security_group_key = "nsg-dmz-inet-iac-integration-dev-appgw-01"
#       }
#     }
#     resource_group_name = "rg-inet-iac-integration-dev-01"
#   }
# }
