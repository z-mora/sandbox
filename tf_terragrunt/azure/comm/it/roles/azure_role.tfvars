azure_roles = {
  "role-parsons-alz-admin" = {
    actions      = ["*"]
    data_actions = []
    not_actions = [
      "Microsoft.Authorization/roleAssignments/delete",
      "Microsoft.Authorization/roleAssignments/write",
      "Microsoft.Blueprint/blueprintAssignments/delete",
      "Microsoft.Blueprint/blueprintAssignments/write",
      "Microsoft.Compute/galleries/share/action",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/publicIPAddresses/write",
      "Microsoft.Network/routeTables/delete",
      "Microsoft.Network/routeTables/join/action",
      "Microsoft.Network/routeTables/routes/delete",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/virtualHubs/*",
      "Microsoft.Network/VirtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/delete",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/delete",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
      "Microsoft.Network/VirtualNetworks/write",
      "Microsoft.Network/virtualRouters/delete",
      "Microsoft.Network/virtualRouters/peerings/delete",
      "Microsoft.Network/virtualRouters/peerings/write",
      "Microsoft.Network/virtualRouters/write",
      "Microsoft.Network/virtualWans/*",
    ]
    not_data_actions = []
    role_description = <<-EOL
    The generic role assigned to ALZ admins to manage their ALZ. All actions are allowed
    except for some network exceptions. If a custom role is needed to get around some
    of the restrictions a custom role should be created within their subscription and
    assigned instead.
    EOL
    scope            = "/providers/Microsoft.Management/managementGroups/Parsons"
  }
  "role-parsons-alz-inet-admin" = {
    actions      = ["*"]
    data_actions = []
    not_actions = [
      "Microsoft.Blueprint/blueprintAssignments/delete",
      "Microsoft.Blueprint/blueprintAssignments/write",
      "Microsoft.Compute/galleries/share/action",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/routeTables/delete",
      "Microsoft.Network/routeTables/join/action",
      "Microsoft.Network/routeTables/routes/delete",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/virtualHubs/*",
      "Microsoft.Network/VirtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/delete",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/delete",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
      "Microsoft.Network/VirtualNetworks/write",
      "Microsoft.Network/virtualRouters/delete",
      "Microsoft.Network/virtualRouters/peerings/delete",
      "Microsoft.Network/virtualRouters/peerings/write",
      "Microsoft.Network/virtualRouters/write",
      "Microsoft.Network/virtualWans/*",
    ]
    not_data_actions = []
    role_description = <<-EOL
    The generic role assigned to ALZ inet admins. It mirrors role-parsons-alz-admin
    except for allowing role assignment writes and deletes.
    EOL
    scope            = "/providers/Microsoft.Management/managementGroups/Parsons"
  }
}
