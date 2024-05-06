vpcs = {
  "vpc-dmz-parsons-gov-mtc-epoch1-dev-01" = {
    cidr_block = "10.187.9.0/25"
    private_subnets = {
      "PrivateSubnet1" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.187.9.0/25"
      }
    }
    transit_gateway_id = "tgw-0f7a6373c722643fa"
  }
}
