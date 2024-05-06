virtual_networks = {
  "vnet-sandbox-platform-01" = {
    cidr     = ["10.208.76.0/22"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-sandbox-platform-01" = {
        address_prefixes           = ["10.208.76.0/25"]
        network_security_group_key = "nsg-sandbox-platform-01"
      }
      "subnet-sandbox-platform-02" = {
        address_prefixes           = ["10.208.76.128/25"]
        network_security_group_key = "nsg-sandbox-platform-01"
      }
      "subnet-sandbox-platform-03" = {
        address_prefixes           = ["10.208.77.0/25"]
        network_security_group_key = "nsg-sandbox-platform-01"
      }
      "subnet-sandbox-platform-04" = {
        address_prefixes           = ["10.208.77.128/25"]
        network_security_group_key = "nsg-sandbox-platform-01"
      }
    }
    resource_group_name = "rg-network-platform-01"
  }
}
