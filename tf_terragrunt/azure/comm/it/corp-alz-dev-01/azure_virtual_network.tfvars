

virtual_networks = {
  "vnet-dmz-alz-dev-01" = {
    cidr                = ["10.212.46.0/24"]
    is_dmz              = true
    location            = "eastus2"
    resource_group_name = "rg-alz-dev-01"
    dns_servers         = ["10.208.74.4"]
    private_subnets = {
      "subnet-dmz-alz-dev-01" = {
        address_prefixes           = ["10.212.46.0/24"]
        network_security_group_key = "nsg-alz-dev-01"
      }
    }
  }
}
