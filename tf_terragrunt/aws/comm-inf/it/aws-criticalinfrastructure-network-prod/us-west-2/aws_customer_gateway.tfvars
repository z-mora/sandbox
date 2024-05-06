customer_gateways = {
  "CGW-35.166.183.205" = {
    bgp_asn    = 65026
    ip_address = "35.166.183.205"
    vpn_connections = {
      "VPN-to-CGW-35.166.183.205" = {
        transit_gateway_key = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
      }
    }
  }
  "CGW-44.236.58.115" = {
    bgp_asn    = 65026
    ip_address = "44.236.58.115"
    vpn_connections = {
      "VPN-to-CGW-44.236.58.115" = {
        transit_gateway_key = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
      }
    }
  }
}
