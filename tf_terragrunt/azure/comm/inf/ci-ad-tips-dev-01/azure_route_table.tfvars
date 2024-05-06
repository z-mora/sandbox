route_tables = {
  "rt-ad-tips-dev-01" = {
    location            = "eastus2"
    resource_group_name = "rg-ad-tips-dev-01"
    routes = {
      "route-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
  "rt-ad-tips-dev-appgw-01" = {
    location            = "eastus2"
    resource_group_name = "rg-ad-tips-dev-01"
    routes = {
      "route-10-to-ilb" = {
        address_prefix         = "10.0.0.0/8"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
      "route-172-to-ilb" = {
        address_prefix         = "172.16.0.0/12"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
      "route-default-to-internet-appgw" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = ""
        next_hop_type          = "Internet"
      }
    }
  }
}
