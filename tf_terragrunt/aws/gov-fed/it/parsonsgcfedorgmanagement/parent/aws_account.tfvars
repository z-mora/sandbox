# Corp Move to OU | GovCloud Parents
account_details = {
  email_address = "aws-gc-fed-orgmanagement@parsons.com"
  name          = "ParsonsGCFedOrgManagement"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223506bf2b7bbc8"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223506bf2b7bbc8/ps-ac42c1012743f0f9"
    principal_id       = "90676d0f56-74207264-ec60-4408-842b-8cb68c7be3dd"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
