common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223c4e3db5b8d02"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223c4e3db5b8d02/ps-0fc764fecac7b4bf"
    principal_id       = "906760b843-be78f6d3-187f-4fae-981d-43617dce512d"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "ORGMANAGEMENT-ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223c4e3db5b8d02"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223c4e3db5b8d02/ps-aac8b57743a5aaf8"
    principal_id       = "906760b843-b2eed015-4d17-407e-9d29-f10390c36972"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "READONLY-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223c4e3db5b8d02"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223c4e3db5b8d02/ps-43c04543c46b974a"
    principal_id       = "906760b843-33d1c156-1302-4cf3-b846-d5f96cbdfb7b"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223c4e3db5b8d02"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223c4e3db5b8d02/ps-9f028068b57f3477"
    principal_id       = "906760b843-97e01f4a-b407-461d-a429-85743d667e96"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }

}
management_account_role = "arn:aws:iam::831463143379:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "870528785099"
profile                 = "oce-ss"
sso_region              = "us-east-1"
