vpcs = {
  "vpc-internal-parsons-com-dems-dev-01" = {
    cidr_block = "10.41.88.0/24"
    dhcp_options = {
      domain_name         = "parsons.com"
      domain_name_servers = ["10.41.255.16", "10.41.255.76"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.41.88.0/25"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.41.88.128/25"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}
