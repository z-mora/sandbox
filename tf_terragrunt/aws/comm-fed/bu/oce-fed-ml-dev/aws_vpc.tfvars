vpcs = {
  "vpc-oce-fed-ml-dev-01" = {
    cidr_block = "10.189.4.0/24"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.189.4.0/25"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.189.4.128/25"
      }
    }
    transit_gateway_id = "tgw-09d640413187fdc74"
  }
}
