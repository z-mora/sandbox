virtual_networks = {
  "vnet-internal-private-endpoint-hub-eastus2-prod-01" = {
    cidr     = ["10.208.84.0/24"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-internal-private-endpoint-hub-eastus2-prod-01" = {
        address_prefixes           = ["10.208.84.0/24"]
        network_security_group_key = "nsg-internal-private-endpoint-hub-eastus2-prod-01"
      }
    }
    resource_group_name = "rg-private-endpoint-hub-prod-01"
  }
  "vnet-internal-private-endpoint-hub-westus2-prod-01" = {
    cidr     = ["10.208.85.0/24"]
    is_dmz   = false
    location = "westus2"
    private_subnets = {
      "subnet-internal-private-endpoint-hub-westus2-prod-01" = {
        address_prefixes           = ["10.208.85.0/24"]
        network_security_group_key = "nsg-internal-private-endpoint-hub-westus2-prod-01"
      }
    }
    resource_group_name = "rg-private-endpoint-hub-prod-01"
  }
}
