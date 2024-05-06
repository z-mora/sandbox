virtual_networks = {
  "vnet-dmz-corp-ai-prod-usgovvirginia-01" = {
    cidr                            = ["10.220.4.0/24"]
    is_dmz                          = true
    link_dns_hub_forwarding_ruleset = true
    location                        = "usgovvirginia"
    private_subnets = {
      "subnet-dmz-corp-ai-prod-usgovvirginia-01" = {
        address_prefixes           = ["10.220.4.0/26"]
        network_security_group_key = "nsg-dmz-corp-ai-prod-usgovvirginia-01"
      }
      "subnet-dmz-corp-ai-prod-usgovvirginia-02" = {
        address_prefixes           = ["10.220.4.64/26"]
        network_security_group_key = "nsg-dmz-corp-ai-prod-usgovvirginia-01"
      }
      "subnet-dmz-corp-ai-prod-usgovvirginia-03" = {
        address_prefixes           = ["10.220.4.128/26"]
        network_security_group_key = "nsg-dmz-corp-ai-prod-usgovvirginia-01"
      }
      "subnet-dmz-corp-ai-prod-postgresql-usgovvirginia-04" = {
        address_prefixes           = ["10.220.4.192/26"]
        network_security_group_key = "nsg-dmz-corp-ai-prod-usgovvirginia-01"
        delegation_name            = "Microsoft.DBforPostgreSQL.flexibleServers"
        delegation_service         = "Microsoft.DBforPostgreSQL/flexibleServers"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        route_table_key            = "rt-dmz-corp-ai-prod-postgresql-usgovvirginia-01"
      }
    }
    resource_group_name = "rg-corp-ai-prod-01"
  }
}
