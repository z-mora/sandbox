route_tables = {
  "rt-paloalto-eastus2-trust-01" = {
    location            = "eastus2"
    resource_group_name = "rg-network-prod-01"
    routes = {
      "route-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
  "rt-paloalto-eastus2-untrust-01" = {
    disable_bgp_route_propagation = true
    location                      = "eastus2"
    resource_group_name           = "rg-network-prod-01"
    routes = {
      "route-default-to-azure-internet" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = ""
        next_hop_type          = "Internet"
      }
    }
  }
  "rt-paloalto-westus2-trust-01" = {
    location            = "westus2"
    resource_group_name = "rg-network-prod-01"
    routes = {
      "route-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "10.210.2.134"
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
  "rt-paloalto-westus2-untrust-01" = {
    disable_bgp_route_propagation = true
    location                      = "westus2"
    resource_group_name           = "rg-network-prod-01"
    routes = {
      "route-default-to-azure-internet" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = ""
        next_hop_type          = "Internet"
      }
    }
  }
}
