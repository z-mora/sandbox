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
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223712ec1eef0db"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223712ec1eef0db/ps-91c07ed54a8d5c36"
    principal_id       = "906769a29a-0a6f28da-b2b2-413e-8e0c-e67fe05c42fd"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223712ec1eef0db"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223712ec1eef0db/ps-7d566fa2896cea91"
    principal_id       = "906769a29a-aaba021a-e6a5-46e7-a425-c1a4adfea941"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws:iam::615231544573:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "766333593242"
profile                 = "oce-ss"
sso_region              = "us-east-1"
