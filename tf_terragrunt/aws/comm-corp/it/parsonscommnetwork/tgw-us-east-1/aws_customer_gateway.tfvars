customer_gateways = {
  "CGW-206.219.248.6" = {
    bgp_asn    = 65524
    ip_address = "206.219.248.6"
    vpn_connections = {
      "VPN-to-CGW-206.219.248.6" = {
        transit_gateway_key = "TGW-1-Comm-East"
      }
    }
  }
  "CGW-209.128.255.149" = {
    bgp_asn    = 65200
    ip_address = "209.128.255.149"
    vpn_connections = {
      "VPN-to-CGW-209.128.255.149" = {
        transit_gateway_key = "TGW-1-Comm-East"
      }
    }
  }
}
