virtual_networks = {
  "vnet-dmz-inet-njdot-dev-eastus2-01" = {
    cidr                          = ["10.212.64.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.67.192/26"]
    private_subnets = {
      "subnet-dmz-inet-njdot-dev-eastus2-01" = {
        address_prefixes           = ["10.212.64.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-02" = {
        address_prefixes           = ["10.212.64.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
        delegation_name            = "dlg-Microsoft.DBforMySQL-flexibleServers"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
      }
      "subnet-dmz-inet-njdot-dev-eastus2-03" = {
        address_prefixes           = ["10.212.64.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-04" = {
        address_prefixes           = ["10.212.64.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-05" = {
        address_prefixes           = ["10.212.65.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-06" = {
        address_prefixes           = ["10.212.65.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-07" = {
        address_prefixes           = ["10.212.65.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-08" = {
        address_prefixes           = ["10.212.65.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-09" = {
        address_prefixes           = ["10.212.66.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-10" = {
        address_prefixes           = ["10.212.66.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-11" = {
        address_prefixes           = ["10.212.66.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-12" = {
        address_prefixes           = ["10.212.66.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-13" = {
        address_prefixes           = ["10.212.67.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-14" = {
        address_prefixes           = ["10.212.67.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-njdot-dev-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.67.128/26"]
        network_security_group_key = "nsg-dmz-inet-appgw-njdot-dev-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-njdot-dev-01"
  }
}
