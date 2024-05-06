# Corp Move to OU | Sandbox/Dev: ou-gvmm-yaxwtbvy | Workload/prod: ou-gvmm-s0k5pivc | Workload/SDLC: ou-gvmm-80v05kfy
account_details = {
  additional_sso_assignments = {
    "SRE-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-a98f0c48a7aad88e"
      principal_type     = "GROUP"
      principal_id       = "906708fe40-c2c8cbcb-ddeb-49a3-916c-2982df4c25b8"
    }
  }
  additional_alternate_contacts = {
    "ServerManagement" = {
      alternate_contact_type = "OPERATIONS"
      title                  = "ServerManagement"
      email_address          = "servermanagement@parsons.com"
      phone_number           = "800-252-8108"
    }
  }
  email_address = "aws+test310@gotnetwork.com"
  name          = "oce-infraops-sandbox-10"
  parent_ou_id  = "ou-gvmm-yaxwtbvy"
}
