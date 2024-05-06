customer_gateways = {
  "CGW-3.96.83.233" = {
    bgp_asn    = 65046
    ip_address = "3.96.83.233"
    vpn_connections = {
      "VPN-to-CGW-3.96.83.233" = {
        transit_gateway_key = "tgw-1-ci-internal-ca-central-1-to-ca-central-1-corp-it"
      }
    }
  }
  "CGW-3.99.11.7" = {
    bgp_asn    = 65046
    ip_address = "3.99.11.7"
    vpn_connections = {
      "VPN-to-CGW-3.99.11.7" = {
        transit_gateway_key = "tgw-1-ci-internal-ca-central-1-to-ca-central-1-corp-it"
      }
    }
  }
}
