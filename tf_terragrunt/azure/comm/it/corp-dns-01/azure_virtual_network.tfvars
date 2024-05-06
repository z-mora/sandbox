virtual_networks = {
  "vnet-int-dns-prod-eastus2-01" = {
    cidr        = ["10.208.74.0/23"]
    is_dmz      = false
    location    = "eastus2"
    dns_servers = []
    private_subnets = {
      "subnet-int-dns-inbound-prod-eastus2-01" = {
        address_prefixes           = ["10.208.74.0/24"]
        network_security_group_key = "nsg-int-dns-prod-eastus2-01"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
      }
      "subnet-int-dns-outbound-prod-eastus2-02" = {
        address_prefixes           = ["10.208.75.0/24"]
        network_security_group_key = "nsg-int-dns-prod-eastus2-01"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
      }
    }
    resource_group_name = "rg-dns-prod-01"
  }
  "vnet-int-dns-prod-westus2-01" = {
    cidr        = ["10.208.80.0/23"]
    is_dmz      = false
    location    = "westus2"
    dns_servers = []
    private_subnets = {
      "subnet-int-dns-inbound-prod-westus2-01" = {
        address_prefixes           = ["10.208.80.0/24"]
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
        network_security_group_key = "nsg-int-dns-prod-westus2-01"
      }
      "subnet-int-dns-outbound-prod-westus2-02" = {
        address_prefixes           = ["10.208.81.0/24"]
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
        network_security_group_key = "nsg-int-dns-prod-westus2-01"
      }
    }
    resource_group_name = "rg-dns-prod-01"
  }
}
