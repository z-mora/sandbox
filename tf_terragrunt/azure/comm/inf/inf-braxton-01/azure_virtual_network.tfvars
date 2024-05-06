virtual_networks = {
  "vnet-dmz-braxton-eastus2-01" = {
    cidr     = ["10.212.60.0/22"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-dmz-braxton-eastus2-01" = {
        address_prefixes           = ["10.212.60.0/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-02" = {
        address_prefixes           = ["10.212.60.64/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-03" = {
        address_prefixes           = ["10.212.60.128/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-04" = {
        address_prefixes           = ["10.212.60.192/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-05" = {
        address_prefixes           = ["10.212.61.0/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-06" = {
        address_prefixes           = ["10.212.61.64/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-07" = {
        address_prefixes           = ["10.212.61.128/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-08" = {
        address_prefixes           = ["10.212.61.192/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-09" = {
        address_prefixes           = ["10.212.62.0/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-10" = {
        address_prefixes           = ["10.212.62.64/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-11" = {
        address_prefixes           = ["10.212.62.128/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-12" = {
        address_prefixes           = ["10.212.62.192/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-13" = {
        address_prefixes           = ["10.212.63.0/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-14" = {
        address_prefixes           = ["10.212.63.64/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-15" = {
        address_prefixes           = ["10.212.63.128/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
      "subnet-dmz-braxton-eastus2-16" = {
        address_prefixes           = ["10.212.63.192/26"]
        network_security_group_key = "nsg-dmz-braxton-eastus2-01"
      }
    }
    resource_group_name = "rg-braxton-dev-01"
  }
}
