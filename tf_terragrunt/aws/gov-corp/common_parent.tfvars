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
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223b8bca6133ba8"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223b8bca6133ba8/ps-073f4548cf815e72"
    principal_id       = "9067615d55-991027f4-e454-47f4-9145-e20486b3e81e"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws:iam::229273762103:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "243823722059"
profile                 = "oce-ss"
region                  = "us-east-1"
sso_region              = "us-east-1"
