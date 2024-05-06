# route_tables = {
#   "rt-pweb-api-dev-dmz-01" = {
#     disable_bgp_route_propagation = "false"
#     location                      = "westus2"
#     resource_group_name           = "rg-pweb-api-dev-01"
#     routes = {
#       "route-default-to-ilb" = {
#         address_prefix         = "0.0.0.0/0"
#         next_hop_in_ip_address = "10.210.2.134"
#         next_hop_type          = "VirtualAppliance"
#       }
#     }
#   }
#   "rt-pweb-api-dev-dmz-02-appgw" = {
#     disable_bgp_route_propagation = "false"
#     location                      = "westus2"
#     resource_group_name           = "rg-pweb-api-dev-01"
#     routes = {
#       "route-10-to-ilb" = {
#         address_prefix         = "10.0.0.0/8"
#         next_hop_in_ip_address = "10.210.2.134"
#         next_hop_type          = "VirtualAppliance"
#       }
#       "route-172-to-ilb" = {
#         address_prefix         = "172.16.0.0/12"
#         next_hop_in_ip_address = "10.210.2.134"
#         next_hop_type          = "VirtualAppliance"
#       }
#       "route-default-to-internet-appgw" = {
#         address_prefix         = "0.0.0.0/0"
#         next_hop_in_ip_address = ""
#         next_hop_type          = "Internet"
#       }
#     }
#   }
# }
