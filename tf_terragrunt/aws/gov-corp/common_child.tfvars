common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-2949e334b217cfe3"
    principal_id       = "98673fa9ee-a300b56f-7bc8-4a40-a2df-f465dcf9b615"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-d620fec6c0451eac"
    principal_id       = "98673fa9ee-fe800746-fbcf-439e-96fa-c525658aceab"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-PROTECT-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-e527e5f4e85d7650"
    principal_id       = "98673fa9ee-be0a3c02-c1b0-4d0d-a72d-b35592f3eced"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-RESPOND-Role" = {
    instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
    permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-2d981bfd0c4057d7"
    principal_id       = "98673fa9ee-358d4bae-2cfc-4fdf-9d59-ab6f2486cadf"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws-us-gov:iam::309961722645:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "305517462403"
profile                 = "pce-ss"
root_ou                 = "r-aytg"
sso_region              = "us-gov-west-1"
