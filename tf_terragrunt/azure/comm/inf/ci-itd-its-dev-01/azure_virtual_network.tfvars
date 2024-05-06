virtual_networks = {
  "vnet-itd-its-dev-01" = {
    cidr     = ["10.212.0.0/23"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-itd-its-dev-01" = {
        address_prefixes           = ["10.212.0.0/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-02" = {
        address_prefixes           = ["10.212.0.64/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-03" = {
        address_prefixes           = ["10.212.0.128/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-04" = {
        address_prefixes           = ["10.212.0.192/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web",
          "Microsoft.ContainerRegistry"
        ]
        delegation_name    = "Microsoft.DBforMySQL.flexibleServers"
        delegation_service = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      "subnet-itd-its-dev-05" = {
        address_prefixes           = ["10.212.1.0/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-06" = {
        address_prefixes           = ["10.212.1.64/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-07" = {
        address_prefixes           = ["10.212.1.128/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
      "subnet-itd-its-dev-08" = {
        address_prefixes           = ["10.212.1.192/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Web"
        ]
      }
    }
    resource_group_name = "rg-itd-its-dev-01"
  }
}
