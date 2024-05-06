# Corp Move to OU | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
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
    "ROUTE53-xatorcorp-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-1e5f2c14e6c64e30"
      principal_type     = "GROUP"
      principal_id       = "a4688418-d0c1-7026-eca1-b7354c1f36d1"
    }
    "SRE-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-a98f0c48a7aad88e"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-c2c8cbcb-ddeb-49a3-916c-2982df4c25b8"
    }
    "TERRAFORM-S3-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-7e6f1a062e1f3d6d"
      principal_type     = "GROUP"
      principal_id       = "84f88418-f021-70db-9c66-b1bf066ebcf7"
    }
  }
  email_address = "AWS-ParsonsCommShared@parsons.com"
  name          = "ParsonsCommShared"
  parent_ou_id  = "ou-gvmm-s0k5pivc"
}
