virtual_networks = {
  "vnet-inetdatahub-oak-dev-01" = {
    cidr                          = ["10.212.40.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.43.192/26"]
    private_subnets = {
      "subnet-inetdatahub-oak-dev-01" = {
        address_prefixes           = ["10.212.40.0/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-02" = {
        address_prefixes           = ["10.212.40.64/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-03" = {
        address_prefixes           = ["10.212.40.128/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-04" = {
        address_prefixes           = ["10.212.40.192/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-05" = {
        address_prefixes           = ["10.212.41.0/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-06" = {
        address_prefixes           = ["10.212.41.64/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-07" = {
        address_prefixes           = ["10.212.41.128/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-08" = {
        address_prefixes           = ["10.212.41.192/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-09" = {
        address_prefixes           = ["10.212.42.0/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-10" = {
        address_prefixes           = ["10.212.42.64/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "subnet-inetdatahub-oak-dev-11" = {
        address_prefixes           = ["10.212.42.128/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.42.192/26"]
        network_security_group_key = "nsg-bastion-01"
        service_endpoints          = []
      }
      "subnet-inetdatahub-oak-dev-azurefunctions" = {
        address_prefixes           = ["10.212.43.0/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-inetdatahub-oak-dev-mysql" = {
        address_prefixes           = ["10.212.43.64/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-01"
        delegation_name            = "mysqlflexibledelegation"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      "subnet-inetdatahub-oak-dev-appgw-01" = {
        address_prefixes           = ["10.212.43.128/26"]
        network_security_group_key = "nsg-inetdatahub-oak-dev-appgw-01"
      }
    }
    resource_group_name = "rg-inetdatahub-oak-dev-01"
  }
}
