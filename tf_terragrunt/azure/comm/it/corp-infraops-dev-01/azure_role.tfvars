# azure_roles = {
#   "role-subscription-infraops-dev-01-admin" = {
#     actions      = ["*"]
#     data_actions = []
#     not_actions = [
#       "Microsoft.Blueprint/blueprintAssignments/delete",
#       "Microsoft.Blueprint/blueprintAssignments/write",
#       "Microsoft.Compute/galleries/share/action",
#       "Microsoft.Insights/DiagnosticSettings/Delete",
#       "Microsoft.Insights/DiagnosticSettings/Write",
#       "Microsoft.Network/privateDnsZones/delete",
#       "Microsoft.Network/privateDnsZones/write",
#       "Microsoft.Network/privateDnsZones/join/action",
#       "Microsoft.Network/virtualHubs/*",
#       "Microsoft.Network/VirtualNetworks/Delete",
#       "Microsoft.Network/VirtualNetworks/write",
#       "Microsoft.Network/virtualNetworks/subnets/Delete",
#       "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/Delete",
#       "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/Write",
#       "Microsoft.Network/virtualRouters/Delete",
#       "Microsoft.Network/virtualRouters/peerings/Delete",
#       "Microsoft.Network/virtualRouters/peerings/Write",
#       "Microsoft.Network/virtualRouters/Write",
#       "Microsoft.Network/virtualWans/*",
#     ]
#     not_data_actions = []
#     role_description = "Subscription role to allow for all actions with some network exceptions."
#   }
# }
