customer_gateways = {
  "CGW-18.253.98.40" = {
    bgp_asn    = 64910
    ip_address = "18.253.98.40"
    vpn_connections = {
      "VPN-to-CGW-18.253.98.40" = {
        transit_gateway_key = "TGW-1-FEDGC-INTERNAL-US-GOV-EAST-1-TO-US-GOV-EAST-1-CORP-IT"
      }
    }
  }
  "CGW-18.253.189.59" = {
    bgp_asn    = 64910
    ip_address = "18.253.189.59"
    vpn_connections = {
      "VPN-to-CGW-18.253.189.59" = {
        transit_gateway_key = "TGW-1-FEDGC-INTERNAL-US-GOV-EAST-1-TO-US-GOV-EAST-1-CORP-IT"
      }
    }
  }
}
