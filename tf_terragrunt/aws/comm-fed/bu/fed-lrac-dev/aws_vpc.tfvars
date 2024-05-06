vpcs = {
  "vpc-oce-fed-lrac-dev-01" = {
    cidr_block = "10.41.115.0/24"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.41.115.0/25"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.41.115.128/25"
      }
    }
    transit_gateway_id = "tgw-09d640413187fdc74"
  }
  "vpc-oce-fed-lrac-dev-02" = {
    cidr_block = "10.189.5.0/24"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.189.5.0/25"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.189.5.128/25"
      }
    }
    transit_gateway_id = "tgw-09d640413187fdc74"
  }
}
