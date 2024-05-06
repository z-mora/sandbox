# Corp Move to OU | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
account_details = {
  email_address = "aws-comm-fed-orgmanagement@parsons.com"
  name          = "ParsonsCommFedOrgManagement"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223820ec3844642"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223820ec3844642/ps-b50ecab2e16dd3f8"
    principal_id       = "90676a0168-4f39d558-28d0-43cf-a5ef-572015776927"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
