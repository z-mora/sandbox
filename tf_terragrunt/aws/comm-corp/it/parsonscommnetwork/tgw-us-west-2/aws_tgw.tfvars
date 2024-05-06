transit_gateways = {
  "TGW-1-Internal-Comm-US-West-2" = {
    amazon_side_asn                 = 65020
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-1-Internal-Comm-US-West-2"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-COMM-PARSONS-COM-DMZ-US-WEST-2" = {
    amazon_side_asn                 = 65024
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-COMM-PARSONS-COM-DMZ-US-WEST-2"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-COMM-PARSONSEXT-COM-DMZ-US-WEST-2" = {
    amazon_side_asn                 = 65023
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-COMM-PARSONSEXT-COM-DMZ-US-WEST-2"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
}
