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
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223506bf2b7bbc8"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223506bf2b7bbc8/ps-ac42c1012743f0f9"
    principal_id       = "90676d0f56-580681cc-80bb-411f-9340-651a911f3aa6"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}

management_account_role = "arn:aws:iam::631776075052:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "469183462070"
profile                 = "oce-ss"
region                  = "us-east-1"
sso_region              = "us-east-1"
