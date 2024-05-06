# Corp Move to OU | GovCloud Parents
account_details = {
  email_address = "aws-parsonsgcorgmaster@parsons.com"
  name          = "ParsonsGCOrgMaster"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223b8bca6133ba8"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223b8bca6133ba8/ps-073f4548cf815e72"
    principal_id       = "9067615d55-00f2f4df-68a9-4846-bef2-683fac1a53c5"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
