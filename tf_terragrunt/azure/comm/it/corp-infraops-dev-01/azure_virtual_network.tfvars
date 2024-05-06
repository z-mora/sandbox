virtual_networks = {
  "vnet-dmz-infraops-dev-eastus2" = {
    cidr                            = ["10.212.44.0/24"]
    is_dmz                          = true
    link_dns_hub_forwarding_ruleset = true
    location                        = "eastus2"
    private_subnets = {
      "subnet-dmz-infraops-dev-01" = {
        address_prefixes           = ["10.212.44.0/25"]
        network_security_group_key = "nsg-dmz-infraops-dev-eastus2"
      }
      "subnet-dmz-infraops-dev-02" = {
        address_prefixes           = ["10.212.44.128/25"]
        network_security_group_key = "nsg-dmz-infraops-dev-eastus2"
        delegation_name            = "Microsoft.DBforPostgreSQL.flexibleServers"
        delegation_service         = "Microsoft.DBforPostgreSQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
    resource_group_name = "rg-infraops-dev-01"
  }
  # "vnet-internal-infraops-dev-eastus2" = {
  #   cidr                   = ["10.208.82.0/24"]
  #   is_dmz                 = false
  #   location               = "eastus2"
  #   private_subnets = {
  #     "subnet-internal-infraops-dev-eastus2-01" = {
  #       address_prefixes           = ["10.208.82.0/25"]
  #       network_security_group_key = "nsg-infraops-dev-eastus2"
  #     }
  #     "subnet-internal-infraops-dev-eastus2-02" = {
  #       address_prefixes           = ["10.208.82.128/25"]
  #       network_security_group_key = "nsg-infraops-dev-eastus2"
  #     }
  #   }
  #   resource_group_name = "rg-infraops-dev-01"
  # }
}
