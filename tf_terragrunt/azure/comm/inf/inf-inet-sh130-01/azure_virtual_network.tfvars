virtual_networks = {
  "vnet-dmz-inet-sh130-prod-eastus2-01" = {
    cidr                          = ["10.212.84.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.87.192/26"]
    private_subnets = {
      "subnet-dmz-inet-sh130-prod-eastus2-01" = {
        address_prefixes           = ["10.212.84.0/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-02" = {
        address_prefixes           = ["10.212.84.64/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-03" = {
        address_prefixes           = ["10.212.84.128/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-04" = {
        address_prefixes           = ["10.212.84.192/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-05" = {
        address_prefixes           = ["10.212.85.0/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-06" = {
        address_prefixes           = ["10.212.85.64/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-07" = {
        address_prefixes           = ["10.212.85.128/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-08" = {
        address_prefixes           = ["10.212.85.192/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-09" = {
        address_prefixes           = ["10.212.86.0/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-10" = {
        address_prefixes           = ["10.212.86.64/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-11" = {
        address_prefixes           = ["10.212.86.128/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-12" = {
        address_prefixes           = ["10.212.86.192/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-13" = {
        address_prefixes           = ["10.212.87.0/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-14" = {
        address_prefixes           = ["10.212.87.64/26"]
        network_security_group_key = "nsg-dmz-inet-sh130-prod-eastus2-01"
      }
      "subnet-dmz-inet-sh130-prod-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.87.128/26"]
        network_security_group_key = "nsg-dmz-inet-appgw-sh130-prod-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-sh130-prod-01"
  }
}
