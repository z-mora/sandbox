vpcs = {
  "vpc-dmz-parsons-gov-lunar-locust-dev-01" = {
    cidr_block = "10.34.4.0/24"
    private_subnets = {
      "PrivateSubnet1" = {
        availability_zone = "us-gov-west-1a"
        cidr_block        = "10.34.4.0/26"
      }
      "PrivateSubnet2" = {
        availability_zone = "us-gov-west-1b"
        cidr_block        = "10.34.4.64/26"
      }
      "PrivateSubnet3" = {
        availability_zone = "us-gov-west-1c"
        cidr_block        = "10.34.4.128/26"
      }
      "PrivateSubnet4" = {
        availability_zone = "us-gov-west-1a"
        cidr_block        = "10.34.4.192/26"
      }
    }
    transit_gateway_id = "tgw-0ec10462f4d6e1738"
  }
}
