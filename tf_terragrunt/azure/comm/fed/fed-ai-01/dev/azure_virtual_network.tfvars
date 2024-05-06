virtual_networks = {
  "vnet-dmz-fed-ai-dev-westus2-01" = {
    cidr     = ["10.212.76.0/24"]
    is_dmz   = true
    location = "westus2"
    private_subnets = {
      "subnet-dmz-fed-ai-dev-01" = {
        address_prefixes           = ["10.212.76.0/26"]
        network_security_group_key = "nsg-dmz-fed-ai-dev-westus2-01"
      }
      "subnet-dmz-fed-ai-dev-02" = {
        address_prefixes           = ["10.212.76.64/26"]
        network_security_group_key = "nsg-dmz-fed-ai-dev-westus2-01"
      }
      "subnet-dmz-fed-ai-dev-03" = {
        address_prefixes           = ["10.212.76.128/26"]
        network_security_group_key = "nsg-dmz-fed-ai-dev-westus2-01"
      }
      "subnet-dmz-fed-ai-dev-04" = {
        address_prefixes           = ["10.212.76.192/26"]
        network_security_group_key = "nsg-dmz-fed-ai-dev-westus2-01"
      }
    }
    resource_group_name = "rg-fed-ai-dev-01"
  }
}
