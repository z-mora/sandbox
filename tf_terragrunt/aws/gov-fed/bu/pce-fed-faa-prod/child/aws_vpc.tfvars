vpcs = {
  "vpc-dmz-parsons-gov-faa-01" = {
    cidr_block = "10.187.7.0/24"
    private_subnets = {
      "PrivateSubnet1" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.187.7.0/25"
      }
      "PrivateSubnet2" = {
        availability_zone = "us-gov-east-1b"
        cidr_block        = "10.187.7.128/25"
      }
    }
    transit_gateway_id = "tgw-0f7a6373c722643fa"
  }
}
