virtual_networks = {
  "vnet-dmz-fed-ai-prod-westus2-01" = {
    cidr     = ["10.212.78.0/24"]
    is_dmz   = true
    location = "westus2"
    private_subnets = {
      "subnet-dmz-fed-ai-prod-01" = {
        address_prefixes           = ["10.212.78.0/26"]
        network_security_group_key = "nsg-dmz-fed-ai-prod-westus2-01"
      }
      "subnet-dmz-fed-ai-prod-02" = {
        address_prefixes           = ["10.212.78.64/26"]
        network_security_group_key = "nsg-dmz-fed-ai-prod-westus2-01"
      }
      "subnet-dmz-fed-ai-prod-03" = {
        address_prefixes           = ["10.212.78.128/26"]
        network_security_group_key = "nsg-dmz-fed-ai-prod-westus2-01"
      }
      "subnet-dmz-fed-ai-prod-04" = {
        address_prefixes           = ["10.212.78.192/26"]
        network_security_group_key = "nsg-dmz-fed-ai-prod-westus2-01"
      }
    }
    resource_group_name = "rg-fed-ai-prod-01"
  }
}
