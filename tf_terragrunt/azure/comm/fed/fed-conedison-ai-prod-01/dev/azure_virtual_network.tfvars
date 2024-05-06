virtual_networks = {
  "vnet-conedison-ai-dev-01" = {
    cidr     = ["10.212.36.0/24"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-conedison-ai-dev-01" = {
        address_prefixes           = ["10.212.36.0/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-02" = {
        address_prefixes           = ["10.212.36.64/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-03" = {
        address_prefixes           = ["10.212.36.128/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-appgw-01" = {
        address_prefixes           = ["10.212.36.192/26"]
        network_security_group_key = "nsg-conedison-ai-dev-appgw-01"
      }
    }
    resource_group_name = "rg-conedison-ai-dev-01"
  }
}
