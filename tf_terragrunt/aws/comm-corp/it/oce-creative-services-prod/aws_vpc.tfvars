vpcs = {
  "vpc-internal-parsons-com-creative-services-prod" = {
    cidr_block = "10.41.202.0/24"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.41.202.0/25"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.41.202.128/25"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}
