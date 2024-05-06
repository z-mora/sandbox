vpcs = {
  "vpc-internal-parsons-com-us-gov-west-1-prod" = {
    cidr_block = "10.34.0.0/22"
    dhcp_options = {
      domain_name         = "parsons.com"
      domain_name_servers = ["10.33.0.16", "10.33.4.16"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-gov-west-1a"
        cidr_block        = "10.34.0.0/24"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-gov-west-1b"
        cidr_block        = "10.34.1.0/24"
      }
      "PrivateSubnet3A" = {
        availability_zone = "us-gov-west-1c"
        cidr_block        = "10.34.2.0/24"
      }
    }
    transit_gateway_id = "tgw-031a9f9fa81db6a53"
  }
}
