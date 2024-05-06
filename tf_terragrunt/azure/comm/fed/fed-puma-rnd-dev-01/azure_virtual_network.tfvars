virtual_networks = {
  "vnet-puma-rnd-dev-01" = {
    cidr     = ["10.212.12.0/22", "10.212.220.0/22"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-puma-rnd-dev-01" = {
        address_prefixes           = ["10.212.12.0/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-api-appservice" = {
        address_prefixes           = ["10.212.12.64/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
        delegation_name            = "AppServiceNetworkIntegration"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
        service_endpoints = [
          "Microsoft.AzureCosmosDB",
          "Microsoft.CognitiveServices",
          "Microsoft.ContainerRegistry",
          "Microsoft.EventHub",
          "Microsoft.KeyVault",
          "Microsoft.ServiceBus",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web",
        ]
      }
      "subnet-puma-rnd-dev-ui-appservice" = {
        address_prefixes           = ["10.212.12.128/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
        delegation_name            = "AppServiceNetworkIntegration"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-puma-rnd-dev-04" = {
        address_prefixes           = ["10.212.12.192/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-05" = {
        address_prefixes           = ["10.212.13.0/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-06" = {
        address_prefixes           = ["10.212.13.64/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-07" = {
        address_prefixes           = ["10.212.13.128/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-08" = {
        address_prefixes           = ["10.212.13.192/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-09" = {
        address_prefixes           = ["10.212.14.0/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-10" = {
        address_prefixes           = ["10.212.14.64/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-11" = {
        address_prefixes           = ["10.212.14.128/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-12" = {
        address_prefixes           = ["10.212.14.192/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-13" = {
        address_prefixes           = ["10.212.15.0/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-14" = {
        address_prefixes           = ["10.212.15.64/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-15" = {
        address_prefixes           = ["10.212.15.128/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "subnet-puma-rnd-dev-16" = {
        address_prefixes           = ["10.212.15.192/26"]
        network_security_group_key = "nsg-puma-rnd-dev-01"
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.220.0/24"]
        network_security_group_key = "nsg-bastion-01"
        service_endpoints          = []
      }
    }
    resource_group_name = "rg-puma-rnd-dev-01"
  }
}
