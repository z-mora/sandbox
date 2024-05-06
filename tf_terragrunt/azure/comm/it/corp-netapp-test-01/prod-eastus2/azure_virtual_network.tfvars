virtual_networks = {
  "vnet-int-netapp-prod-eastus2-01" = {
    cidr     = ["10.208.67.0/24"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-netapp-prod-eastus2-01" = {
        address_prefixes           = ["10.208.67.0/26"]
        network_security_group_key = "nsg-netapp-prod-01"
      }
      "subnet-netapp-prod-eastus2-02" = {
        address_prefixes           = ["10.208.67.64/26"]
        network_security_group_key = "nsg-netapp-prod-01"
      }
      "subnet-netapp-prod-eastus2-03" = {
        address_prefixes           = ["10.208.67.128/26"]
        network_security_group_key = "nsg-netapp-prod-01"
      }
      "subnet-netapp-prod-eastus2-04" = {
        address_prefixes           = ["10.208.67.192/26"]
        network_security_group_key = "nsg-netapp-prod-01"
      }
    }
    resource_group_name = "rg-netapp-prod-eastus2-01"
  }
}
