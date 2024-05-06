# virtual_networks = {
#   "vnet-pweb-api-dev-dmz-01" = {
#     cidr                   = ["10.212.45.0/24"]
#     is_dmz                 = true
#     location               = "westus2"
#     private_subnets = {
#       "subnet-pweb-api-dev-dmz-01" = {
#         address_prefixes           = ["10.212.45.0/26"]
#         network_security_group_key = "nsg-pweb-api-dev-01"
#         route_table_key            = "rt-pweb-api-dev-dmz-01"
#       }
#       "subnet-pweb-api-dev-dmz-02" = {
#         address_prefixes           = ["10.212.45.64/26"]
#         network_security_group_key = "nsg-pweb-api-dev-01"
#         route_table_key            = "rt-pweb-api-dev-dmz-01"
#       }
#       "subnet-pweb-api-dev-dmz-03-app-service" = {
#         address_prefixes           = ["10.212.45.128/26"]
#         network_security_group_key = "nsg-pweb-api-dev-01"
#         delegation_name            = "MicrosoftWebserverFarms"
#         delegation_service         = "Microsoft.Web/serverFarms"
#         delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
#         route_table_key            = "rt-pweb-api-dev-dmz-01"
#       }
#       "subnet-pweb-api-dev-dmz-04-appgw" = {
#         address_prefixes           = ["10.212.45.192/26"]
#         network_security_group_key = "nsg-pweb-api-dev-appgw-01"
#         route_table_key            = "rt-pweb-api-dev-dmz-02-appgw"
#       }
#     }
#     resource_group_name = "rg-pweb-api-dev-01"
#   }
# }
