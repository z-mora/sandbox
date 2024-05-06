virtual_networks = {
  "vnet-int-netapp-dev-usgovvirginia-01" = {
    cidr     = ["10.222.1.0/24"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-int-netapp-dev-usgovvirginia-01" = {
        address_prefixes           = ["10.222.1.0/24"]
        network_security_group_key = "nsg-int-netapp-dev-usgovvirginia-01"
        delegation_name            = "Microsoft.Netapp/volumes"
        delegation_service         = "Microsoft.Netapp/volumes"
        delegation_actions = [
          "Microsoft.Network/networkinterfaces/*",
          "Microsoft.Network/virtualNetworks/subnets/join/action",
        ]
      }
    }
    resource_group_name = "rg-netapp-dev-01"
  }
}
