virtual_networks = {
  "vnet-dmz-inet-gatekeeper-dev-eastus2-01" = {
    cidr                          = ["10.212.48.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.51.192/26"]
    private_subnets = {
      "subnet-dmz-inet-gatekeeper-dev-eastus2-01" = {
        address_prefixes           = ["10.212.48.0/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-02" = {
        address_prefixes           = ["10.212.48.64/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-03" = {
        address_prefixes           = ["10.212.48.128/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-04" = {
        address_prefixes           = ["10.212.48.192/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-05" = {
        address_prefixes           = ["10.212.49.0/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-06" = {
        address_prefixes           = ["10.212.49.64/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-07" = {
        address_prefixes           = ["10.212.49.128/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-08" = {
        address_prefixes           = ["10.212.49.192/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-09" = {
        address_prefixes           = ["10.212.50.0/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-10" = {
        address_prefixes           = ["10.212.50.64/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-11" = {
        address_prefixes           = ["10.212.50.128/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-12" = {
        address_prefixes           = ["10.212.50.192/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-13" = {
        address_prefixes           = ["10.212.51.0/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-14" = {
        address_prefixes           = ["10.212.51.64/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-dev-eastus2-01"
      }
      "subnet-dmz-inet-gatekeeper-dev-eastus2-appgw-01" = {
        address_prefixes           = ["10.212.51.128/26"]
        network_security_group_key = "nsg-dmz-inet-gatekeeper-appgw-dev-eastus2-01"
      }
    }
    resource_group_name = "rg-inet-gatekeeper-dev-01"
  }
}
