# Corp Move to OU | Sandbox/Dev: ou-aytg-7lzn51bp | Workload/prod: ou-aytg-wf4kzf5x | Workload/SDLC: ou-aytg-kwsnl2wb
account_details = {
  additional_sso_assignments = {
    "NETWORK-Role" = {
      instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-2fcdc1d531becf6c"
      principal_type     = "GROUP"
      principal_id       = "98673fa9ee-6c543814-be89-4f75-977f-382d6af9bb0b"
    }
    "OPERATIONS-SUPPORT-Role" = {
      instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-68b53e8102d0d69f"
      principal_type     = "GROUP"
      principal_id       = "98673fa9ee-11c771e3-6ef6-48c7-952b-07e014a8b827"
    }
    "SRE-Role" = {
      instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-190ca24114f14b20"
      principal_type     = "GROUP"
      principal_id       = "98673fa9ee-ea5d1477-6171-41d7-afc8-13ecc2a514ee"
    }
    "READONLY-Role" = {
      instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-7952d19c97b41ead"
      principal_type     = "GROUP"
      principal_id       = "68a19218-80b1-7074-2530-c37b955d1eb0"
    }
  }
  email_address = "AWS-ParsonsGCShared@parsons.com"
  name          = "pce-shared-services"
  parent_ou_id  = "ou-aytg-wf4kzf5x"
}
