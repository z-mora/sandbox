virtual_networks = {
  "vnet-dmz-inet-njdot-prod-eastus2-01" = {
    cidr                          = ["10.212.68.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.71.192/26"]
    private_subnets = {
      "subnet-dmz-inet-njdot-prod-eastus2-01" = {
        address_prefixes           = ["10.212.68.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-02" = {
        address_prefixes           = ["10.212.68.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
        delegation_name            = "dlg-Microsoft.DBforMySQL-flexibleServers"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
      }
      "subnet-dmz-inet-njdot-prod-eastus2-03" = {
        address_prefixes           = ["10.212.68.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-04" = {
        address_prefixes           = ["10.212.68.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-05" = {
        address_prefixes           = ["10.212.69.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-06" = {
        address_prefixes           = ["10.212.69.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-07" = {
        address_prefixes           = ["10.212.69.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-08" = {
        address_prefixes           = ["10.212.69.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-09" = {
        address_prefixes           = ["10.212.70.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-10" = {
        address_prefixes           = ["10.212.70.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-11" = {
        address_prefixes           = ["10.212.70.128/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-12" = {
        address_prefixes           = ["10.212.70.192/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-13" = {
        address_prefixes           = ["10.212.71.0/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-14" = {
        address_prefixes           = ["10.212.71.64/26"]
        network_security_group_key = "nsg-dmz-inet-njdot-prod-eastus2-01"
      }
      "subnet-dmz-inet-njdot-prod-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.71.128/26"]
        network_security_group_key = "nsg-dmz-inet-appgw-njdot-prod-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-prod-01"
  }
}
