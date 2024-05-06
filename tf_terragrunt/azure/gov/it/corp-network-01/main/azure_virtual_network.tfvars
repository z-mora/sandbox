

virtual_networks = {
  "vnet-firewall-prod-01" = {
    cidr                = ["10.216.2.0/23"]
    location            = "usgovvirginia"
    resource_group_name = "rg-network-prod-01"
    dns_servers         = ["10.33.0.16", "10.33.4.16"]
    private_subnets = {
      "subnet-palo_untrust-prod-01" = {
        address_prefixes           = ["10.216.2.0/25"]
        network_security_group_key = "nsg-firewall_untrust-prod-01"
        service_endpoints = [
          "Microsoft.Storage"
        ]
      }
      "subnet-palo_trust-prod-01" = {
        address_prefixes           = ["10.216.2.128/25"]
        network_security_group_key = "nsg-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.Storage"
        ]
      }
      "subnet-palo_management-prod-01" = {
        address_prefixes           = ["10.216.3.0/25"]
        network_security_group_key = "nsg-firewall_trust-prod-01"
        service_endpoints = [
          "Microsoft.Storage"
        ]
      }
    }
  }
}
