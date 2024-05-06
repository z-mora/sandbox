virtual_networks = {
  "vnet-int-az-migrate-01" = {
    cidr     = ["10.222.3.0/24"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-az-migrate-01" = {
        address_prefixes           = ["10.222.3.0/24"]
        network_security_group_key = "nsg-az-migrate-01"
      }
    }
    resource_group_name = "rg-az-migrate-01"
  }
}
