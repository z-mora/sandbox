# Corp Move to OU | Sandbox/Dev: ou-aytg-7lzn51bp | Workload/prod: ou-aytg-wf4kzf5x | Workload/SDLC: ou-aytg-kwsnl2wb
account_details = {
  additional_sso_assignments = {
    "SRE-Role" = {
      instance_arn       = "arn:aws-us-gov:sso:::instance/ssoins-7907a395e1400b3f"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws-us-gov:sso:::permissionSet/ssoins-7907a395e1400b3f/ps-190ca24114f14b20"
      principal_type     = "GROUP"
      principal_id       = "98673fa9ee-ea5d1477-6171-41d7-afc8-13ecc2a514ee"
    }
  }
  email_address = "aws+test+pce+03@gotnetwork.com"
  name          = "pce-infraops-sandbox-03"
  parent_ou_id  = "ou-aytg-7lzn51bp"
}
