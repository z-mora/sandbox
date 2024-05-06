transit_gateways = {
  "TGW-1-Comm-East" = {
    amazon_side_asn                 = 65005
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-1-Comm-East"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-2-Comm-East-Parsons-Com-DMZ" = {
    amazon_side_asn                 = 65004
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-2-Comm-East-Parsons-Com-DMZ"
    share_to_principals = [
      "100244082598",
      "153562317406",
      "349531848608",
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-3-Comm-East-Parsonsext-Com-DMZ" = {
    amazon_side_asn                 = 65003
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-3-Comm-East-Parsonsext-Com-DMZ"
    share_to_principals = [
      "100244082598",
      "153562317406",
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
}
