virtual_networks = {
  "vnet-int-dns-prod-usgovvirginia-01" = {
    cidr        = ["10.216.4.0/23"]
    is_dmz      = false
    location    = "usgovvirginia"
    dns_servers = []
    private_subnets = {
      "subnet-int-dns-inbound-prod-usgovvirginia-01" = {
        address_prefixes           = ["10.216.4.0/24"]
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
        network_security_group_key = "nsg-int-dns-prod-usgovvirginia-01"
      }
      "subnet-int-dns-outbound-prod-usgovvirginia-02" = {
        address_prefixes           = ["10.216.5.0/24"]
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        delegation_name            = "Microsoft.Network/dnsResolvers"
        delegation_service         = "Microsoft.Network/dnsResolvers"
        network_security_group_key = "nsg-int-dns-prod-usgovvirginia-01"
      }
    }
    resource_group_name = "rg-dns-prod-01"
  }
}
