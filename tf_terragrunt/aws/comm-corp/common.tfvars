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
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-052a58d36b2c1fbf"
    principal_id       = "906708fe40-d0563544-5db2-49d3-a64d-d4fc819b9f21"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-GENERAL-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-f6d9b5d1df5abbaa"
    principal_id       = "906708fe40-6cde297b-85c0-46f1-ba4a-aa34851934f0"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-PROTECT-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-1a814af0bd28b4e4"
    principal_id       = "906708fe40-25196b21-1533-440b-b074-c138d27bcfac"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
  "SECURITY-RESPOND-Role" = {
    instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-7b4a0ba3c03dc4db"
    principal_id       = "906708fe40-5fbb5ef3-94a3-49be-beff-fc8d3c7f640e"
    principal_type     = "GROUP"
    target_type        = "AWS_ACCOUNT"
  }
}
management_account_role = "arn:aws:iam::489747787081:role/service-role/_sys_terragrunt_admin_role"
network_account_id      = "470088140503"
profile                 = "oce-ss"
sso_region              = "us-east-1"
