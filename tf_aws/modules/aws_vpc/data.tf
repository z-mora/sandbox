data "aws_availability_zones" "allowed" {
  state            = "available"
  exclude_zone_ids = ["use1-az3"]
  # Exclude Local Zones if the account is opted-in
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_iam_policy_document" "cw_log_sub_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "flowlog_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_vpc_dhcp_options" "default" {
  count = var.dhcp_options == null ? 1 : 0

  filter {
    name   = "key"
    values = ["domain-name"]
  }

  filter {
    name   = "value"
    values = ["ec2.internal", "${var.region}.compute.internal"]
  }

  depends_on = [aws_vpc.vpc]
}

#Used to verify a valid transit gateway id was provided
# tflint-ignore: terraform_unused_declarations
/* data "aws_ec2_transit_gateway" "verification" {
  id = var.transit_gateway_id
} */
