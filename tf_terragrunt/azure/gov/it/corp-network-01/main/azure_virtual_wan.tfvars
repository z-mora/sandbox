virtual_wans = {
  "wan-network-prod-01" = {
    allow_branch_to_branch_traffic = true
    disable_vpn_encryption         = false
    location                       = "usgovvirginia"
    resource_group_name            = "rg-network-prod-01"
    type                           = "Standard"
    virtual_hubs = {
      "hub-usgovvirginia-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.52"]
        instance_1_custom_ip        = ["169.254.22.52"]
        internet_security_enabled   = true
        location                    = "usgovvirginia"
        remote_virtual_network_name = "vnet-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.216.0.0/23"
        vpn_gateway_name            = "vpngw-usgovvirginia-prod-01"
      }
    }
    vpn_sites = {
      "vpnsite-sterling-prod-01" = {
        asn                  = 65200
        connection_link_name = "vpnlink-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "usgovvirginia"
        peering_address      = "169.254.21.53"
        provider_name        = "megaport"
        resource_group_name  = "rg-network-prod-01"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key      = "hub-usgovvirginia-prod-01"
        vpn_connection_name  = "vpn-usgovvirginia_sterling-prod-01"
      }
    }
  }
}
