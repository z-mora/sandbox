virtual_networks = {
  "vnet-inet-dev-01" = {
    # Disable because the appgw subnet doesn't have appgw in the name
    auto_create_dmz_route_table   = false
    cidr                          = ["10.212.2.0/23"]
    is_dmz                        = true
    location                      = "eastus2"
    gateway_subnet_address_prefix = ["10.212.3.192/26"]
    private_subnets = {
      "subnet-inet-dev-01" = {
        address_prefixes           = ["10.212.2.0/26"]
        network_security_group_key = "nsg-inet-dev-01"
        route_table_key            = "rt-inet-dev-01"
      }
      "subnet-inet-dev-02" = {
        address_prefixes           = ["10.212.2.64/27"]
        network_security_group_key = "nsg-inet-dev-01"
        route_table_key            = "rt-inet-dev-01"
      }
      "subnet-inet-dev-03" = {
        address_prefixes           = ["10.212.2.128/26"]
        network_security_group_key = "nsg-inet-dev-01"
        route_table_key            = "rt-inet-dev-01"
      }
      "subnet-inet-dev-04" = {
        address_prefixes           = ["10.212.2.192/26"]
        network_security_group_key = "nsg-inet-dev-01"
        route_table_key            = "rt-inet-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.EventHub",
          "Microsoft.KeyVault",
          "Microsoft.ServiceBus",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web",
        ]
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.3.0/26"]
        network_security_group_key = "nsg-bastion-01"
        service_endpoints          = []
      }
      "subnet-inet-dev-06" = {
        address_prefixes           = ["10.212.3.64/26"]
        network_security_group_key = "nsg-inet-dev-appgw-01"
        route_table_key            = "rt-inet-dev-appgw-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-inet-dev-07" = {
        address_prefixes           = ["10.212.3.128/26"]
        network_security_group_key = "nsg-inet-dev-01"
        route_table_key            = "rt-inet-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
    }
    resource_group_name = "rg-inet-dev-01"
  }
}
