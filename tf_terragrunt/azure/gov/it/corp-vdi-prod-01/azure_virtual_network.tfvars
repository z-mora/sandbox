virtual_networks = {
  "vnet-vdi-prod-01" = {
    cidr     = ["10.217.0.0/21"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.217.0.0/22"]
        network_security_group_key = "nsg-vdi-prod-01"
        service_endpoints = [
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
  "vnet-vdi-prod-02" = {
    cidr     = ["10.217.8.0/21"]
    is_dmz   = false
    location = "usgovvirginia"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.217.8.0/22"]
        network_security_group_key = "nsg-vdi-prod-02"
        service_endpoints = [
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
}
