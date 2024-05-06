virtual_networks = {
  "vnet-dmz-fed-ai-test-westus2-01" = {
    cidr     = ["10.212.77.0/24"]
    is_dmz   = true
    location = "westus2"
    private_subnets = {
      "subnet-dmz-fed-ai-test-01" = {
        address_prefixes           = ["10.212.77.0/26"]
        network_security_group_key = "nsg-dmz-fed-ai-test-westus2-01"
      }
      "subnet-dmz-fed-ai-test-02" = {
        address_prefixes           = ["10.212.77.64/26"]
        network_security_group_key = "nsg-dmz-fed-ai-test-westus2-01"
      }
      "subnet-dmz-fed-ai-test-03" = {
        address_prefixes           = ["10.212.77.128/26"]
        network_security_group_key = "nsg-dmz-fed-ai-test-westus2-01"
      }
      "subnet-dmz-fed-ai-test-04" = {
        address_prefixes           = ["10.212.77.192/26"]
        network_security_group_key = "nsg-dmz-fed-ai-test-westus2-01"
      }
    }
    resource_group_name = "rg-fed-ai-test-01"
  }
}
