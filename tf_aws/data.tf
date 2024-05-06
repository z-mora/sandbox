data "aws_organizations_organization" "current" {
  provider = aws.management_account
}

data "aws_partition" "current" {
  provider = aws.management_account
}
