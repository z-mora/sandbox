customer_gateways = {
  "CGW-35.171.238.164" = {
    bgp_asn    = 65006
    ip_address = "35.171.238.164"
    vpn_connections = {
      "VPN-to-CGW-35.171.238.164" = {
        transit_gateway_key = "TGW-1-CI-INTERNAL-US-EAST-2-TO-US-EAST-1-CORP-IT"
      }
    }
  }
  "CGW-3.225.231.251" = {
    bgp_asn    = 65006
    ip_address = "3.225.231.251"
    vpn_connections = {
      "VPN-to-CGW-3.225.231.251" = {
        transit_gateway_key = "TGW-1-CI-INTERNAL-US-EAST-2-TO-US-EAST-1-CORP-IT"
      }
    }
  }
}
