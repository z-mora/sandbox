virtual_networks = {
  "vnet-vdi-prod-01" = {
    cidr     = ["10.209.0.0/21"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.209.0.0/22"]
        network_security_group_key = "nsg-vdi-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
  "vnet-vdi-prod-02" = {
    cidr     = ["10.209.8.0/21"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.209.8.0/22"]
        network_security_group_key = "nsg-vdi-prod-02"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.Storage"
        ]
      }
      "subnet-vdi-prod-05" = {
        address_prefixes           = ["10.209.15.192/26"]
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        network_security_group_key = "nsg-vdi-prod-02"
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
  "vnet-vdi-uaenorth-prod-01" = {
    cidr     = ["10.232.64.0/21"]
    is_dmz   = false
    location = "uaenorth"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.232.64.0/22"]
        network_security_group_key = "nsg-vdi-uaenorth-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
  "vnet-vdi-uaenorth-prod-02" = {
    cidr     = ["10.232.72.0/21"]
    is_dmz   = false
    location = "uaenorth"
    private_subnets = {
      "subnet-vdi-prod-01" = {
        address_prefixes           = ["10.232.72.0/22"]
        network_security_group_key = "nsg-vdi-uaenorth-prod-02"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-vdi-prod-01"
  }
}
