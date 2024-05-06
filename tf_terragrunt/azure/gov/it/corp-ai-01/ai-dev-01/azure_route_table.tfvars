route_tables = {
  rt-dmz-corp-ai-dev-postgresql-usgovvirginia-01 = {
    location            = "usgovvirginia"
    resource_group_name = "rg-corp-ai-dev-01"
    routes = {
      "udr-aad-to-internet" = {
        address_prefix = "AzureActiveDirectory"
        next_hop_type  = "Internet"
      }
      "udr-subnet-cidr-to-vnet" = {
        address_prefix = "10.220.5.192/26"
        next_hop_type  = "VnetLocal"
      }
      "udr-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "TBD" # This will be looked up later in the RT module
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
}
