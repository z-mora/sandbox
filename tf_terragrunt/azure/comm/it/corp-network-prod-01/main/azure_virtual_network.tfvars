virtual_networks = {
  "vnet-firewall-prod-01" = {
    cidr     = ["10.208.2.0/23"]
    location = "eastus2"
    private_subnets = {
      "subnet-palo_management-prod-01" = {
        address_prefixes           = ["10.208.3.0/25"]
        network_security_group_key = "nsg-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-palo_trust-prod-01" = {
        address_prefixes           = ["10.208.2.128/25"]
        network_security_group_key = "nsg-firewall_trust-prod-01"
        route_table_key            = "rt-paloalto-eastus2-trust-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-palo_untrust-prod-01" = {
        address_prefixes           = ["10.208.2.0/25"]
        network_security_group_key = "nsg-firewall_untrust-prod-01"
        route_table_key            = "rt-paloalto-eastus2-untrust-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
  "vnet-uaenorth-firewall-prod-01" = {
    cidr     = ["10.232.2.0/23"]
    location = "uaenorth"
    private_subnets = {
      "subnet-uaenorth-palo_management-prod-01" = {
        address_prefixes           = ["10.232.3.0/25"]
        network_security_group_key = "nsg-uaenorth-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-uaenorth-palo_trust-prod-01" = {
        address_prefixes           = ["10.232.2.128/25"]
        network_security_group_key = "nsg-uaenorth-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-uaenorth-palo_untrust-prod-01" = {
        address_prefixes           = ["10.232.2.0/25"]
        network_security_group_key = "nsg-uaenorth-firewall_untrust-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
  "vnet-westus2-firewall-prod-01" = {
    cidr     = ["10.210.2.0/23"]
    location = "westus2"
    private_subnets = {
      "subnet-westus2-palo_management-prod-01" = {
        address_prefixes           = ["10.210.3.0/25"]
        network_security_group_key = "nsg-westus2-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-westus2-palo_trust-prod-01" = {
        address_prefixes           = ["10.210.2.128/25"]
        network_security_group_key = "nsg-westus2-firewall_trust-prod-01"
        route_table_key            = "rt-paloalto-westus2-trust-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
      "subnet-westus2-palo_untrust-prod-01" = {
        address_prefixes           = ["10.210.2.0/25"]
        network_security_group_key = "nsg-westus2-firewall_untrust-prod-01"
        route_table_key            = "rt-paloalto-westus2-untrust-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.KeyVault",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
}
