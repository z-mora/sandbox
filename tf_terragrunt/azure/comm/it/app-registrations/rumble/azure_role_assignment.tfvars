role_assignments = {
  "rumble-reader" = {
    app_registration_keys = ["_sys_rumble_user"]
    role_name             = "Reader"
    scope = {
      display_name = "Tenant Root Group"
      type         = "management_group"
    }
  }
}
