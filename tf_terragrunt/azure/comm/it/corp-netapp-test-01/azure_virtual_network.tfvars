virtual_networks = {
  "vnet-netapp-test-01" = {
    cidr     = ["10.208.66.0/24"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-netapp-test-01" = {
        address_prefixes           = ["10.208.66.0/26"]
        network_security_group_key = "nsg-netapp-test-01"
      }
      "subnet-netapp-test-02" = {
        address_prefixes           = ["10.208.66.64/26"]
        network_security_group_key = "nsg-netapp-test-01"
      }
      "subnet-netapp-test-03" = {
        address_prefixes           = ["10.208.66.128/26"]
        network_security_group_key = "nsg-netapp-test-01"
      }
      "subnet-netapp-test-04" = {
        address_prefixes           = ["10.208.66.192/26"]
        network_security_group_key = "nsg-netapp-test-01"
      }
    }
    resource_group_name = "rg-netapp-test-01"
  }
}
