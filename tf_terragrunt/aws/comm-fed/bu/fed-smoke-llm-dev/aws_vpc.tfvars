vpcs = {
  "vpc-oce-fed-smoke-llm-dev-01" = {
    cidr_block = "10.189.3.0/24"
    private_subnets = {
      "PrivateSubnet-East1A-General" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.189.3.0/26"
      }
      "PrivateSubnet-East1A-Spot" = {
        availability_zone = "us-east-1a"
        cidr_block        = "10.189.3.64/26"
      }
      "PrivateSubnet-East1B-Spot" = {
        availability_zone = "us-east-1b"
        cidr_block        = "10.189.3.128/27"
      }
      "PrivateSubnet-East1C-Spot" = {
        availability_zone = "us-east-1c"
        cidr_block        = "10.189.3.160/27"
      }
      "PrivateSubnet-East1D-Spot" = {
        availability_zone = "us-east-1d"
        cidr_block        = "10.189.3.192/27"
      }
      "PrivateSubnet-East1F-Spot" = {
        availability_zone = "us-east-1f"
        cidr_block        = "10.189.3.224/27"
      }
    }
    transit_gateway_id = "tgw-09d640413187fdc74"
  }
}
