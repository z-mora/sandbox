# Corp Move to OU | GovCloud Parents
account_details = {
  email_address = "aws-parsonsgcorgmaster@parsons.com"
  name          = "ParsonsGCOrgMaster"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-2949e334b217cfe3"
    principal_id       = "98673fa9ee-9cba7fca-67aa-452b-845c-0ddb0f2e69cd"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
