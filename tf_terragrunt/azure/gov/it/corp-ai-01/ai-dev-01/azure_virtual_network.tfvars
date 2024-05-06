virtual_networks = {
  "vnet-dmz-corp-ai-dev-usgovvirginia-01" = {
    cidr                            = ["10.220.5.0/24"]
    is_dmz                          = true
    link_dns_hub_forwarding_ruleset = true
    location                        = "usgovvirginia"
    private_subnets = {
      "subnet-dmz-fed-ai-dev-usgovvirginia-01" = {
        address_prefixes           = ["10.220.5.0/26"]
        network_security_group_key = "nsg-dmz-corp-ai-dev-usgovvirginia-01"
      }
      "subnet-dmz-fed-ai-dev-usgovvirginia-02" = {
        address_prefixes           = ["10.220.5.64/26"]
        network_security_group_key = "nsg-dmz-corp-ai-dev-usgovvirginia-01"
      }
      "subnet-dmz-fed-ai-dev-usgovvirginia-03" = {
        address_prefixes           = ["10.220.5.128/26"]
        network_security_group_key = "nsg-dmz-corp-ai-dev-usgovvirginia-01"
      }
      "subnet-dmz-fed-ai-dev-postgresql-usgovvirginia-04" = {
        address_prefixes           = ["10.220.5.192/26"]
        network_security_group_key = "nsg-dmz-corp-ai-dev-usgovvirginia-01"
        delegation_name            = "Microsoft.DBforPostgreSQL.flexibleServers"
        delegation_service         = "Microsoft.DBforPostgreSQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        route_table_key            = "rt-dmz-corp-ai-dev-postgresql-usgovvirginia-01"
      }
    }
    resource_group_name = "rg-corp-ai-dev-01"
  }
}
