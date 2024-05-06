resource "aws_ssm_parameter" "environment_tag" {
  name  = "/VPC/${var.vpc_name}/EnvironmentTag"
  type  = "String"
  value = aws_vpc.vpc.tags_all["Environment"]
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/VPC/${var.vpc_name}/PrivateSubnetIDs"
  type  = "StringList"
  value = join(",", [for key, value in aws_subnet.private : value.id])
}

resource "aws_ssm_parameter" "private_subnet_names" {
  name  = "/VPC/${var.vpc_name}/PrivateSubnetNames"
  type  = "StringList"
  value = join(",", [for key, value in aws_subnet.private : key])
}

resource "aws_ssm_parameter" "s3_endpoint" {
  name  = "/VPC/${var.vpc_name}/S3EndpointID"
  type  = "String"
  value = aws_vpc_endpoint.s3.id
}

resource "aws_ssm_parameter" "subnet_az" {
  for_each = aws_subnet.private

  name  = "/VPC/${var.vpc_name}/${each.key}/AZ"
  type  = "String"
  value = each.value.availability_zone
}

resource "aws_ssm_parameter" "subnet_cidr" {
  for_each = aws_subnet.private

  name  = "/VPC/${var.vpc_name}/${each.key}/CIDR"
  type  = "String"
  value = each.value.cidr_block
}

resource "aws_ssm_parameter" "subnet_id" {
  for_each = aws_subnet.private

  name  = "/VPC/${var.vpc_name}/${each.key}/ID"
  type  = "String"
  value = each.value.id
}

resource "aws_ssm_parameter" "vpc_cidr" {
  name  = "/VPC/${var.vpc_name}/CIDR"
  type  = "String"
  value = aws_vpc.vpc.cidr_block
}

resource "aws_ssm_parameter" "vpc_id" {
  name  = "/VPC/${var.vpc_name}/ID"
  type  = "String"
  value = aws_vpc.vpc.id
}
