virtual_networks = {
  "vnet-inetdatahub-nittech-dev-01" = {
    cidr                          = ["10.212.32.0/22"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.35.192/26"]
    private_subnets = {
      "subnet-inetdatahub-nittech-dev-01" = {
        address_prefixes           = ["10.212.32.0/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-02" = {
        address_prefixes           = ["10.212.32.64/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-03" = {
        address_prefixes           = ["10.212.32.128/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-04" = {
        address_prefixes           = ["10.212.32.192/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-05" = {
        address_prefixes           = ["10.212.33.0/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-06" = {
        address_prefixes           = ["10.212.33.64/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-07" = {
        address_prefixes           = ["10.212.33.128/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-08" = {
        address_prefixes           = ["10.212.33.192/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-09" = {
        address_prefixes           = ["10.212.34.0/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-10" = {
        address_prefixes           = ["10.212.34.64/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "subnet-inetdatahub-nittech-dev-11" = {
        address_prefixes           = ["10.212.34.128/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.34.192/26"]
        network_security_group_key = "nsg-bastion-01"
        service_endpoints          = []
      }
      "subnet-inetdatahub-nittech-dev-azurefunctions" = {
        address_prefixes           = ["10.212.35.0/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-inetdatahub-nittech-dev-mysql" = {
        address_prefixes           = ["10.212.35.64/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-01"
        delegation_name            = "mysqlflexibledelegation"
        delegation_service         = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      "subnet-inetdatahub-nittech-dev-appgw-01" = {
        address_prefixes           = ["10.212.35.128/26"]
        network_security_group_key = "nsg-inetdatahub-nittech-dev-appgw-01"
      }
    }
    resource_group_name = "rg-inetdatahub-nittech-dev-01"
  }
}
