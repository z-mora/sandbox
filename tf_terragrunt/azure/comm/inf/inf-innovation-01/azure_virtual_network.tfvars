virtual_networks = {
  "vnet-dmz-innovation-eastus2-01" = {
    cidr     = ["10.212.88.0/24"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-dmz-innovation-eastus2-01" = {
        address_prefixes           = ["10.212.88.0/26"]
        network_security_group_key = "nsg-dmz-innovation-eastus2-01"
      }
      "subnet-dmz-innovation-eastus2-02" = {
        address_prefixes           = ["10.212.88.64/26"]
        network_security_group_key = "nsg-dmz-innovation-eastus2-01"
      }
      "subnet-dmz-innovation-eastus2-03" = {
        address_prefixes           = ["10.212.88.128/26"]
        network_security_group_key = "nsg-dmz-innovation-eastus2-01"
      }
      "subnet-dmz-innovation-eastus2-04" = {
        address_prefixes           = ["10.212.88.192/26"]
        network_security_group_key = "nsg-dmz-innovation-eastus2-01"
      }
    }
    resource_group_name = "rg-innovation-dev-01"
  }
}
