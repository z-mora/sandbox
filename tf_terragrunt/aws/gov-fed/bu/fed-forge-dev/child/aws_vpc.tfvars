vpcs = {
  "vpc-dmz-parsons-gov-forge-dev-01" = {
    cidr_block = "10.33.181.0/24"
    private_subnets = {
      "PrivateSubnet1" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.33.181.0/26"
      }
      "PrivateSubnet2" = {
        availability_zone = "us-gov-east-1b"
        cidr_block        = "10.33.181.64/26"
      }
      "PrivateSubnet3" = {
        availability_zone = "us-gov-east-1c"
        cidr_block        = "10.33.181.128/26"
      }
      "PrivateSubnet4" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.33.181.192/26"
      }
    }
    transit_gateway_id = "tgw-0f7a6373c722643fa"
  }
}
