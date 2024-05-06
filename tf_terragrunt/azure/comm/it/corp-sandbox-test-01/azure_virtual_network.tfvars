virtual_networks = {
  "vnet-sandbox-test-01" = {
    cidr     = ["10.208.68.0/22"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-sandbox-test-01" = {
        address_prefixes           = ["10.208.68.0/25"]
        network_security_group_key = "nsg-sandbox-test-01"
      }
      "subnet-sandbox-test-02" = {
        address_prefixes           = ["10.208.68.128/25"]
        network_security_group_key = "nsg-sandbox-test-01"
      }
    }
    resource_group_name = "rg-network-test-01"
  }
}
