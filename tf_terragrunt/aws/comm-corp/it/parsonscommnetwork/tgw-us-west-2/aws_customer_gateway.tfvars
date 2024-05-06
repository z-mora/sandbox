customer_gateways = {
  "CGW-209.128.255.149" = {
    bgp_asn    = 65200
    ip_address = "209.128.255.149"
    vpn_connections = {
      "VPN-to-CGW-209.128.255.149" = {
        transit_gateway_key = "TGW-1-Internal-Comm-US-West-2"
      }
    }
  }
}
