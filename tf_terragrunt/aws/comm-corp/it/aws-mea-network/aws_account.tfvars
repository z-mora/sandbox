# Corp Move to OU | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
account_details = {
  additional_sso_assignments = {
    "NETWORK-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-925bcfd846934cfc"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-0ce8af51-331e-4a56-8ca7-28a4980b3fd9"
    }
    "OPERATIONS-SUPPORT-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-d5b89de7cf37ae2c"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-da5d02ef-e2ef-4352-b5b2-2109d7b66b79"
    }
  }
  email_address = "aws-mea-network@parsons.com"
  name          = "AWS-MEA-NETWORK"
  parent_ou_id  = "ou-gvmm-4czp2onm"
}
