role_assignments = {
  "Grant service account access to ALZs" = {
    app_registration_keys = [
      "_sys_platform_terragrunt_admin",
    ]
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "mg-landingzones-01"
      type         = "management_group"
    }
  }
}
