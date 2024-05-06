# Corp Move to OU | GovCloud Parents
account_details = {
  email_address = "aws-gc-fed-orgmanagement@parsons.com"
  name          = "ParsonsGCFedOrgManagement"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-790726591fd6179f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-790726591fd6179f/ps-1e5313f0c2a1a59c"
    principal_id       = "98673efedd-c69dc564-434d-450c-817c-2afc00410c9b"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}

region = "us-gov-west-1"
