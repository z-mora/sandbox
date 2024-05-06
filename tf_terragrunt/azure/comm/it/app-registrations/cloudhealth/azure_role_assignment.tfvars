role_assignments = {
  "cloudhealth-reader" = {
    app_registration_keys = ["_sys_cloudhealth_user"]
    role_name             = "Reader"
    scope = {
      display_name = "Tenant Root Group"
      type         = "management_group"
    }
  }
}
