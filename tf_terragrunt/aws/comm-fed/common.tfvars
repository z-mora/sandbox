common_account_contacts = {
  "CyberRespond" = {
    alternate_contact_type = "SECURITY"
    email_address          = "cyberrespond@parsons.com"
    phone_number           = "800-252-8108"
    title                  = "CyberRespond"
  }
}
common_account_sso_assignments = {
  "ADMIN-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223820ec3844642"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223820ec3844642/ps-b50ecab2e16dd3f8"
    principal_id       = "90676a0168-11bb9bf6-d3aa-4141-bb8e-413dd5efaf91"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223820ec3844642"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223820ec3844642/ps-d57fb3c896d5a727"
    principal_id       = "90676a0168-bc3d6118-d124-4fa7-8237-316638dc97d4"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-PROTECT-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223820ec3844642"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223820ec3844642/ps-8445317cdc5c547d"
    principal_id       = "90676a0168-89bee483-3d97-4463-844d-27ad1c38ba6a"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-RESPOND-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223820ec3844642"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223820ec3844642/ps-a1be3634a82c1d05"
    principal_id       = "90676a0168-779bf122-ad91-4675-865a-fc2749199fa9"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws:iam::083108702086:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "219854468849"
profile                 = "oce-ss"
sso_region              = "us-east-1"
