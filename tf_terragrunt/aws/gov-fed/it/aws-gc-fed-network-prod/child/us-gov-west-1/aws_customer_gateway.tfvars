customer_gateways = {
  "CGW-3.32.114.11" = {
    bgp_asn    = 64941
    ip_address = "3.32.114.11"
    vpn_connections = {
      "VPN-to-CGW-3.32.114.11" = {
        transit_gateway_key = "tgw-1-fedgc-internal-us-gov-west-1-to-us-gov-west-1-corp-it"
      }
    }
  }
  "CGW-15.200.102.83" = {
    bgp_asn    = 64941
    ip_address = "15.200.102.83"
    vpn_connections = {
      "VPN-to-CGW-15.200.102.83" = {
        transit_gateway_key = "tgw-1-fedgc-internal-us-gov-west-1-to-us-gov-west-1-corp-it"
      }
    }
  }
}
