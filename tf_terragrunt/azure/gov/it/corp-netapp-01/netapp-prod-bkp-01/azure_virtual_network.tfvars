virtual_networks = {
  "vnet-int-netapp-prod-bkp-usgovvirginia-01" = {
    cidr     = ["10.222.16.0/27"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-int-netapp-prod-bkp-usgovvirginia-01" = {
        address_prefixes           = ["10.222.16.0/27"]
        network_security_group_key = "nsg-int-netapp-prod-bkp-usgovvirginia-01"
        # delegation_name            = "Microsoft.Netapp/volumes"
        # delegation_service         = "Microsoft.Netapp/volumes"
        # delegation_actions = [
        #   "Microsoft.Network/networkinterfaces/*",
        #   "Microsoft.Network/virtualNetworks/subnets/join/action",
        # ]
      }
    }
    resource_group_name = "rg-netapp-prod-bkp-01"
  }
}
