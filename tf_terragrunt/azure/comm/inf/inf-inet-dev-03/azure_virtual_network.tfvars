virtual_networks = {
  "vnet-dmz-inet-dev-eastus2-01" = {
    cidr                          = ["10.212.52.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.55.192/26"]
    private_subnets = {
      "subnet-dmz-inet-dev-eastus2-01" = {
        address_prefixes           = ["10.212.52.0/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-02" = {
        address_prefixes           = ["10.212.52.64/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-03" = {
        address_prefixes           = ["10.212.52.128/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-04" = {
        address_prefixes           = ["10.212.52.192/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-05" = {
        address_prefixes           = ["10.212.53.0/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-06" = {
        address_prefixes           = ["10.212.53.64/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-07" = {
        address_prefixes   = ["10.212.53.128/26"]
        delegation_name    = "managedinstancedelegation"
        delegation_service = "Microsoft.Sql/managedInstances"
        delegation_actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-08" = {
        address_prefixes           = ["10.212.53.192/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-09" = {
        address_prefixes           = ["10.212.54.0/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-10" = {
        address_prefixes           = ["10.212.54.64/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-11" = {
        address_prefixes           = ["10.212.54.128/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-12" = {
        address_prefixes           = ["10.212.54.192/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-13" = {
        address_prefixes           = ["10.212.55.0/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-14" = {
        address_prefixes           = ["10.212.55.64/26"]
        network_security_group_key = "nsg-dmz-inet-dev-eastus2-01"
      }
      "subnet-dmz-inet-dev-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.55.128/26"]
        network_security_group_key = "nsg-dmz-inet-appgw-dev-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-dev-01"
  }
}
