virtual_networks = {
  "vnet-inet-dev2-01" = {
    cidr                          = ["10.212.16.0/20"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.31.128/26"]
    private_subnets = {
      "subnet-inet-dev2-01" = {
        address_prefixes           = ["10.212.16.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-02" = {
        address_prefixes           = ["10.212.17.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-03" = {
        address_prefixes           = ["10.212.18.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-04" = {
        address_prefixes           = ["10.212.19.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-05" = {
        address_prefixes           = ["10.212.20.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-06" = {
        address_prefixes           = ["10.212.21.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-07" = {
        address_prefixes           = ["10.212.22.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-08" = {
        address_prefixes           = ["10.212.23.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-09" = {
        address_prefixes           = ["10.212.24.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-10" = {
        address_prefixes           = ["10.212.25.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-11" = {
        address_prefixes           = ["10.212.26.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-12" = {
        address_prefixes           = ["10.212.27.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-13" = {
        address_prefixes           = ["10.212.28.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-14" = {
        address_prefixes           = ["10.212.29.0/24"]
        network_security_group_key = "nsg-inet-dev2-01"
      }
      "subnet-inet-dev2-appgw-01" = {
        address_prefixes           = ["10.212.30.0/24"]
        network_security_group_key = "nsg-inet-dev2-appgw-01"
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.31.0/26"]
        network_security_group_key = "nsg-inet-dev2-bastion-01"
        service_endpoints          = []
      }
    }
    resource_group_name = "rg-inet-dev-02"
  }
}
