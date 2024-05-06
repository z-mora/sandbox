transit_gateways = {
  "TGW-1-Internal-ME-South-1" = {
    amazon_side_asn                 = 65100
    auto_accept_shared_attachments  = true
    cidr_blocks                     = ["10.224.52.0/24"]
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-1-Internal-ME-South-1"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-2-Parsonscom-DMZ-ME-South-1" = {
    amazon_side_asn                 = 65101
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-2-Parsonscom-DMZ-ME-South-1"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
  "TGW-3-Parsonsextcom-DMZ-ME-South-1" = {
    amazon_side_asn                 = 65102
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-3-Parsonsextcom-DMZ-ME-South-1"
    share_to_principals = [
      "arn:aws:organizations::489747787081:organization/o-xkwln3lsqp",
    ]
  }
}
