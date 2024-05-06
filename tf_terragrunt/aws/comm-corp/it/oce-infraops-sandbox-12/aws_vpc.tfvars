vpcs = {
  "vpc-internal-parsons-com-sandbox-12-01" = {
    cidr_block = "10.41.253.0/24"
    dhcp_options = {
      domain_name         = "parsons.com"
      domain_name_servers = ["10.41.255.16", "10.41.255.76"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.41.253.0/26"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.41.253.64/26"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}
