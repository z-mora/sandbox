customer_gateways = {
  "CGW-15.184.240.148" = {
    bgp_asn    = 65112
    ip_address = "15.184.240.148"
    vpn_connections = {
      "VPN-to-CGW-15.184.240.148" = {
        transit_gateway_key = "TGW-1-Internal-ME-South-1"
      }
    }
  }
  "CGW-206.219.250.149" = {
    bgp_asn    = 65515
    ip_address = "206.219.250.149"
    vpn_connections = {
      "VPN-to-CGW-206.219.250.149" = {
        transit_gateway_key = "TGW-1-Internal-ME-South-1"
      }
    }
  }
  "CGW-206.219.250.150" = {
    bgp_asn    = 65515
    ip_address = "206.219.250.150"
    vpn_connections = {
      "VPN-to-CGW-206.219.250.150" = {
        transit_gateway_key = "TGW-1-Internal-ME-South-1"
      }
    }
  }
}
