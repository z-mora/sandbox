vpcs = {
  "vpc-dmz-parsons-com-nittec-prod-01" = {
    cidr_block = "10.191.8.0/23"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.191.8.0/26"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.191.8.64/26"
      }
      "PrivateSubnet3A" = {
        availability_zone = "us-east-1c"
        cidr_block        = "10.191.8.128/26"
      }
      "PrivateSubnet1B" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.191.9.0/26"
      }
      "PrivateSubnet2B" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.191.9.64/26"
      }
      "PrivateSubnet3B" = {
        availability_zone = "us-east-1c"
        cidr_block        = "10.191.9.128/26"
      }
    }
    transit_gateway_id = "tgw-0c88433b99cf1ee35"
  }
}
