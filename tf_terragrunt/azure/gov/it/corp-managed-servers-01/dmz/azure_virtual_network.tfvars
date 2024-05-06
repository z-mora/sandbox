virtual_networks = {
  "vnet-dmz-managed-servers-usgovvirginia-01" = {
    cidr     = ["10.220.0.0/22"]
    is_dmz   = true
    location = "usgovvirginia"
    private_subnets = {
      "subnet-dmz-managed-servers-prod-usgovvirginia-01" = {
        address_prefixes           = ["10.220.0.0/23"]
        network_security_group_key = "nsg-dmz-managed-servers-usgovvirginia-01"
      }
      "subnet-dmz-managed-servers-dev-usgovvirginia-01" = {
        address_prefixes           = ["10.220.2.0/24"]
        network_security_group_key = "nsg-dmz-managed-servers-usgovvirginia-01"
      }
      "subnet-dmz-managed-servers-test-usgovvirginia-01" = {
        address_prefixes           = ["10.220.3.0/25"]
        network_security_group_key = "nsg-dmz-managed-servers-usgovvirginia-01"
      }
      "subnet-dmz-managed-servers-qa-usgovvirginia-01" = {
        address_prefixes           = ["10.220.3.128/25"]
        network_security_group_key = "nsg-dmz-managed-servers-usgovvirginia-01"
      }
    }
    resource_group_name = "rg-dmz-managed-servers-01"
  }
}
