virtual_networks = {
  "vnet-itd-its-prod-01" = {
    cidr                          = ["10.212.4.0/22"]
    is_dmz                        = true
    location                      = "westus2"
    gateway_subnet_address_prefix = ["10.212.7.192/26"]
    private_subnets = {
      "subnet-itd-its-prod-01" = {
        address_prefixes           = ["10.212.4.0/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-02" = {
        address_prefixes           = ["10.212.4.64/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-03" = {
        address_prefixes           = ["10.212.4.128/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-04" = {
        address_prefixes           = ["10.212.4.192/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-05" = {
        address_prefixes           = ["10.212.5.0/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-06" = {
        address_prefixes           = ["10.212.5.64/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-07" = {
        address_prefixes           = ["10.212.5.128/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-08" = {
        address_prefixes           = ["10.212.5.192/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-09" = {
        address_prefixes           = ["10.212.6.0/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-10" = {
        address_prefixes           = ["10.212.6.64/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-11" = {
        address_prefixes           = ["10.212.6.128/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-12" = {
        address_prefixes           = ["10.212.6.192/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-13" = {
        address_prefixes           = ["10.212.7.0/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
      }
      "subnet-itd-its-prod-mysql" = {
        address_prefixes           = ["10.212.7.64/26"]
        network_security_group_key = "nsg-itd-its-prod-01"
        delegation_name            = "mysqlflexibledelegation"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      "subnet-itd-its-prod-appgw-01" = {
        address_prefixes           = ["10.212.7.128/26"]
        network_security_group_key = "nsg-itd-its-prod-appgw-01"
      }
    }
    resource_group_name = "rg-itd-its-prod-01"
  }
}
