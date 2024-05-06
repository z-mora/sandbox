common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-790726591fd6179f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-790726591fd6179f/ps-1e5313f0c2a1a59c"
    principal_id       = "98673efedd-e12ff125-5257-45f2-b1c7-81fe43ef3367"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-790726591fd6179f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-790726591fd6179f/ps-0ff63f79e884d592"
    principal_id       = "98673efedd-6869ba42-811b-4138-82fb-0e7f68c89f4c"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-PROTECT-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-790726591fd6179f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-790726591fd6179f/ps-6e6a3846ff5ce8cf"
    principal_id       = "98673efedd-0ba26808-b3ed-4c87-9661-d2cb519dfdbc"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-RESPOND-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-790726591fd6179f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-790726591fd6179f/ps-d355b2635a16b16f"
    principal_id       = "98673efedd-5018d43d-e111-4938-aaae-302ff5371775"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws-us-gov:iam::132340534103:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "306226182832"
profile                 = "pce-ss"
root_ou                 = "r-x9bp"
sso_region              = "us-gov-west-1"
