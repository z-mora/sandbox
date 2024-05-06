virtual_networks = {
  "vnet-njatms-dev-01" = {
    cidr     = ["10.212.11.0/24"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-njatms-dev-01" = {
        address_prefixes           = ["10.212.11.0/26"]
        network_security_group_key = "nsg-njatms-dev-01"
      }
      "subnet-njatms-dev-02" = {
        address_prefixes           = ["10.212.11.64/26"]
        network_security_group_key = "nsg-njatms-dev-01"
      }
      "subnet-njatms-dev-03" = {
        address_prefixes           = ["10.212.11.128/26"]
        network_security_group_key = "nsg-njatms-dev-01"
      }
      "subnet-njatms-dev-04" = {
        address_prefixes           = ["10.212.11.192/26"]
        network_security_group_key = "nsg-njatms-dev-01"
        delegation_name            = "mysqlflexibledelegation"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
    resource_group_name = "rg-njatms-dev-01"
  }
}
