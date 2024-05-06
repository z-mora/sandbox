# Comm Corp OUs | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/Prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
account_details = {
  additional_alternate_contacts = {
    "ServerManagement" = {
      alternate_contact_type = "OPERATIONS"
      email_address          = "ServerManagement@parsons.com"
      phone_number           = "800-252-8108"
      title                  = "ServerManagement"
    }
  }
  additional_sso_assignments = {
    "SRE-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-a98f0c48a7aad88e"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-c2c8cbcb-ddeb-49a3-916c-2982df4c25b8"
    }
    "OPERATIONS-SUPPORT-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-d5b89de7cf37ae2c"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-da5d02ef-e2ef-4352-b5b2-2109d7b66b79"
    }
  }
  email_address = "aws-comm-opde-prod@parsons.com"
  name          = "aws-comm-opde-prod"
  parent_ou_id  = "ou-gvmm-s0k5pivc"
}
