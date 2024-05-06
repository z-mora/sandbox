account_details = {
  additional_sso_assignments = {
    "DBA-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-532f0cb718171e11"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-5d7f60a3-c391-44e8-b933-166922c9f5ee"
    }
    "IDENTITY-ARCHITECTURE-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-9ebfd3eaf27745e4"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-a9f5d3a8-72a6-4b82-9c43-ab4d0b2890e4"
    }
    "MEA-OPERATIONS-SUPPORT-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-2b858d397d8ed979"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-49117952-5085-4b43-ad45-cf1db68145bf"
    }
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
    "READONLY-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-2ba43159ceaae089"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-6b5e3feb-036e-48b0-84d7-3fd3b6ce0d52"
    }
  }
  additional_alternate_contacts = {
    "ServerManagement" = {
      alternate_contact_type = "OPERATIONS"
      email_address          = "ServerManagement@parsons.com"
      phone_number           = "800-252-8108"
      title                  = "ServerManagement"
    }
  }
  email_address = "aws-mea-prod@parsons.com"
  name          = "AWS-MEA-PROD"
  parent_ou_id  = "ou-gvmm-g7gxyai6"
}
