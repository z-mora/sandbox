transit_gateways = {
  "tgw-comm-internal-ca-central-1" = {
    amazon_side_asn                 = 65040
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "tgw-comm-internal-ca-central-1"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
}
