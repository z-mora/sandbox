vpcs = {
  "vpc-internal-parsons-us-testdev" = {
    cidr_block = "10.33.136.0/23"
    dhcp_options = {
      domain_name         = "parsons.us"
      domain_name_servers = ["10.33.0.16", "10.33.4.16"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.33.136.0/24"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-gov-east-1b"
        cidr_block        = "10.33.137.0/24"
      }
    }
    transit_gateway_id = "tgw-04f84dad5b4b26500"
  }
}
