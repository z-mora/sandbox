vpcs = {
  "vpc-dmz-parsons-gov-hive-aoi3-dev-01" = {
    cidr_block = "10.33.179.0/24"
    private_subnets = {
      "PrivateSubnet1" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.33.179.0/26"
      }
      "PrivateSubnet2" = {
        availability_zone = "us-gov-east-1b"
        cidr_block        = "10.33.179.64/26"
      }
      "PrivateSubnet3" = {
        availability_zone = "us-gov-east-1c"
        cidr_block        = "10.33.179.128/26"
      }
      "PrivateSubnet4" = {
        availability_zone = "us-gov-east-1a"
        cidr_block        = "10.33.179.192/26"
      }
    }
    transit_gateway_id = "tgw-0f7a6373c722643fa"
  }
}
