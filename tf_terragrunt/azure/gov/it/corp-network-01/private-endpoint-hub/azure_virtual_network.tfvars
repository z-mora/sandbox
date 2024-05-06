virtual_networks = {
  "vnet-internal-private-endpoint-hub-usgovvirginia-prod-01" = {
    cidr     = ["10.216.8.0/22"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-internal-private-endpoint-hub-usgovvirginia-prod-01" = {
        address_prefixes           = ["10.216.8.0/22"]
        network_security_group_key = "nsg-internal-private-endpoint-hub-usgovvirginia-prod-01"
      }
    }
    resource_group_name = "rg-private-endpoint-hub-prod-01"
  }
}
