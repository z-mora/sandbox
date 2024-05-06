virtual_networks = {
  "vnet-dmz-globalstar-eastus2-01" = {
    cidr     = ["10.212.72.0/23"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-dmz-globalstar-eastus2-01" = {
        address_prefixes           = ["10.212.72.0/26"]
        network_security_group_key = "nsg-dmz-globalstar-eastus2-01"
      }
      "subnet-dmz-globalstar-eastus2-02" = {
        address_prefixes           = ["10.212.72.64/26"]
        network_security_group_key = "nsg-dmz-globalstar-eastus2-01"
      }
      "subnet-dmz-globalstar-eastus2-03" = {
        address_prefixes           = ["10.212.72.128/26"]
        network_security_group_key = "nsg-dmz-globalstar-eastus2-01"
      }
    }
    resource_group_name = "rg-globalstar-dev-01"
  }
}
