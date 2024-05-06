virtual_wans = {
  "wan-network-prod-01" = {
    allow_branch_to_branch_traffic = true
    disable_vpn_encryption         = false
    location                       = "eastus2"
    resource_group_name            = "rg-network-prod-01"
    type                           = "Standard"
    virtual_hubs = {
      "hub-eastus2-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.2"]
        instance_1_custom_ip        = ["169.254.22.2"]
        internet_security_enabled   = true
        location                    = "eastus2"
        remote_virtual_network_name = "vnet-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.208.0.0/23"
        vpn_gateway_name            = "vpngw-eastus2-prod-01"
      }
      "hub-uaenorth-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.18"]
        instance_1_custom_ip        = ["169.254.22.18"]
        internet_security_enabled   = true
        location                    = "uaenorth"
        remote_virtual_network_name = "vnet-uaenorth-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.232.0.0/23"
        vpn_gateway_name            = "vpngw-uaenorth-prod-01"
      }
      "hub-westus2-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.10"]
        instance_1_custom_ip        = ["169.254.22.10"]
        internet_security_enabled   = true
        location                    = "westus2"
        remote_virtual_network_name = "vnet-westus2-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.210.0.0/23"
        vpn_gateway_name            = "vpngw-westus2-prod-01"
      }
    }
    vpn_sites = {
      "vpnsite-sterling-prod-01" = {
        asn                  = 65200
        connection_link_name = "vpnlink-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "eastus2"
        peering_address      = "169.254.21.3"
        provider_name        = "megaport"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key      = "hub-eastus2-prod-01"
        vpn_connection_name  = "vpn-eastus2_sterling-prod-01"
      }
      "vpnsite-uaenorth-awsmesouth-prod-02" = {
        asn                  = 65112
        connection_link_name = "vpnlink-uaenorth-awsmesouth-prod-01"
        device_model         = "CiscoCSR"
        device_vendor        = "Cisco"
        location             = "uaenorth"
        peering_address      = "169.254.21.19"
        provider_name        = "aws"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "15.184.197.25"
        speed_in_mbps        = 1000
        virtual_hub_key      = "hub-uaenorth-prod-01"
        vpn_connection_name  = "vpn-uaenorth-awsmesouth-prod-01"
      }
      "vpnsite-westus2-sterling-prod-02" = {
        asn                  = 65200
        connection_link_name = "vpnlink-westus2-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "westus2"
        peering_address      = "169.254.21.11"
        provider_name        = "megaport"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key      = "hub-westus2-prod-01"
        vpn_connection_name  = "vpn-westus2_sterling-prod-01"
      }
    }
  }
}
