virtual_networks = {
  "vnet-dmz-inet-txdot-dev-eastus2-01" = {
    cidr                          = ["10.212.80.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.83.192/26"]
    private_subnets = {
      "subnet-dmz-inet-txdot-dev-eastus2-01" = {
        address_prefixes           = ["10.212.80.0/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-02" = {
        address_prefixes           = ["10.212.80.64/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-03" = {
        address_prefixes           = ["10.212.80.128/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-04" = {
        address_prefixes           = ["10.212.80.192/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-05" = {
        address_prefixes           = ["10.212.81.0/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-06" = {
        address_prefixes           = ["10.212.81.64/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-07" = {
        address_prefixes           = ["10.212.81.128/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-08" = {
        address_prefixes           = ["10.212.81.192/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-09" = {
        address_prefixes           = ["10.212.82.0/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-10" = {
        address_prefixes           = ["10.212.82.64/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-11" = {
        address_prefixes           = ["10.212.82.128/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-12" = {
        address_prefixes           = ["10.212.82.192/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-13" = {
        address_prefixes           = ["10.212.83.0/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-14" = {
        address_prefixes           = ["10.212.83.64/26"]
        network_security_group_key = "nsg-dmz-inet-txdot-dev-eastus2-01"
      }
      "subnet-dmz-inet-txdot-dev-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.83.128/26"]
        network_security_group_key = "nsg-dmz-inet-appgw-txdot-dev-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-txdot-dev-01"
  }
}
