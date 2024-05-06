virtual_networks = {
  "vnet-int-managed-servers-usgovvirginia-01" = {
    cidr     = ["10.222.4.0/22"]
    location = "usgovvirginia"
    is_dmz   = false
    private_subnets = {
      "subnet-int-managed-servers-prod-usgovvirginia-01" = {
        address_prefixes           = ["10.222.4.0/23"]
        network_security_group_key = "nsg-int-managed-servers-usgovvirginia-01"
      }
      "subnet-int-managed-servers-dev-usgovvirginia-01" = {
        address_prefixes           = ["10.222.6.0/24"]
        network_security_group_key = "nsg-int-managed-servers-usgovvirginia-01"
      }
      "subnet-int-managed-servers-test-usgovvirginia-01" = {
        address_prefixes           = ["10.222.7.0/25"]
        network_security_group_key = "nsg-int-managed-servers-usgovvirginia-01"
      }
      "subnet-int-managed-servers-qa-usgovvirginia-01" = {
        address_prefixes           = ["10.222.7.128/25"]
        network_security_group_key = "nsg-int-managed-servers-usgovvirginia-01"
      }
    }
    resource_group_name = "rg-int-managed-servers-01"
  }
}
