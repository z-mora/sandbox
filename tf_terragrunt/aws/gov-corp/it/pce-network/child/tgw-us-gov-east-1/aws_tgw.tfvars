transit_gateways = {
  "TGW-GC-East-1-Internal" = {
    amazon_side_asn                 = 64901
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-GC-East-1-Internal"
    share_to_principals = [
      "arn:aws-us-gov:organizations::309961722645:organization/o-bty1f0zk8i",
    ]
  }
  "TGW-GC-East-1-Parsons-Com-DMZ" = {
    amazon_side_asn                 = 64902
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-GC-East-1-Parsons-Com-DMZ"
    share_to_principals = [
      "arn:aws-us-gov:organizations::309961722645:organization/o-bty1f0zk8i",
    ]
  }
  "TGW-GC-East-1-Parsonsext-Com-DMZ" = {
    amazon_side_asn                 = 64903
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-GC-East-1-Parsonsext-Com-DMZ"
    share_to_principals = [
      "arn:aws-us-gov:organizations::309961722645:organization/o-bty1f0zk8i",
    ]
  }
  "TGW-GC-EAST-1-SELF-SERVICE-DEVELOPMENT" = {
    amazon_side_asn                 = 64920
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-GC-EAST-1-SELF-SERVICE-DEVELOPMENT"
    share_to_principals = [
      "arn:aws-us-gov:organizations::309961722645:organization/o-bty1f0zk8i",
    ]
  }
}
