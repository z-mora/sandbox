transit_gateways = {
  "TGW-GC-West-1-Internal" = {
    amazon_side_asn                 = 64931
    auto_accept_shared_attachments  = true
    default_route_table_association = true
    default_route_table_propagation = true
    description                     = "TGW-GC-West-1-Internal"
    share_to_principals = [
      "arn:aws-us-gov:organizations::309961722645:organization/o-bty1f0zk8i",
    ]
  }
  "TGW-GC-West-1-INDURE" = {
    amazon_side_asn                = 64942
    auto_accept_shared_attachments = true
    description                    = "TGW-GC-West-1-INDURE"
    share_to_principals            = ["416322655687", ]
  }
}
