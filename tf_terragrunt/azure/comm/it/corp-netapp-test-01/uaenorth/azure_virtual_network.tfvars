virtual_networks = {
  "vnet-netapp-mea-test-01" = {
    cidr     = ["10.232.4.0/24"]
    is_dmz   = false
    location = "uaenorth"
    private_subnets = {
      "subnet-netapp-test-01" = {
        address_prefixes           = ["10.232.4.0/26"]
        network_security_group_key = "nsg-netapp-uaenorth-test-01"
        delegation_name            = "Microsoft.Netapp/volumes"
        delegation_service         = "Microsoft.Netapp/volumes"
        delegation_actions = [
          "Microsoft.Network/networkinterfaces/*",
          "Microsoft.Network/virtualNetworks/subnets/join/action",
        ]
      }
      "subnet-netapp-test-02" = {
        address_prefixes           = ["10.232.4.64/26"]
        network_security_group_key = "nsg-netapp-uaenorth-test-01"
      }
      "subnet-netapp-test-03" = {
        address_prefixes           = ["10.232.4.128/26"]
        network_security_group_key = "nsg-netapp-uaenorth-test-01"
      }
      "subnet-netapp-test-04" = {
        address_prefixes           = ["10.232.4.192/26"]
        network_security_group_key = "nsg-netapp-uaenorth-test-01"
      }
    }
    resource_group_name = "rg-netapp-mea-test-01"
  }
}
