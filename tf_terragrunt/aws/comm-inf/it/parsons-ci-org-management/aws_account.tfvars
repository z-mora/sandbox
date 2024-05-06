# Corp Move to OU | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
account_details = {
  email_address = "aws-criticalinfrastructure-orgmanagement@parsons.com"
  name          = "parsons-ci-org-management"
}

common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223712ec1eef0db"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223712ec1eef0db/ps-91c07ed54a8d5c36"
    principal_id       = "906769a29a-62c46609-f08e-4a7e-b09a-9c5b73c42c44"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
