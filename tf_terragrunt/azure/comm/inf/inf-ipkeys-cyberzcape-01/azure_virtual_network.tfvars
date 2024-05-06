virtual_networks = {
  "vnet-dmz-ipkeys-cyberzcape-prod-eastus2-01" = {
    cidr                          = ["10.212.79.0/24"]
    gateway_subnet_address_prefix = ["10.212.79.192/26"]
    is_dmz                        = true
    location                      = "eastus2"
    private_subnets = {
      "subnet-dmz-ipkeys-cyberzcape-prod-eastus2-01" = {
        address_prefixes           = ["10.212.79.0/26"]
        network_security_group_key = "nsg-dmz-ipkeys-cyberzcape-prod-eastus2-01"
      }
      "subnet-dmz-ipkeys-cyberzcape-prod-eastus2-02" = {
        address_prefixes           = ["10.212.79.64/26"]
        network_security_group_key = "nsg-dmz-ipkeys-cyberzcape-prod-eastus2-01"
      }
      "subnet-dmz-ipkeys-cyberzcape-prod-eastus2-03" = {
        address_prefixes           = ["10.212.79.128/26"]
        network_security_group_key = "nsg-dmz-ipkeys-cyberzcape-prod-eastus2-01"
      }
    }
    resource_group_name = "rg-ipkeys-cyberzcape-prod-01"
  }
}
