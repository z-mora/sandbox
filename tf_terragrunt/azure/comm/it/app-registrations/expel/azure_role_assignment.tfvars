role_assignments = {
  "expel-lar" = {
    app_registration_keys = ["_sys_expel_mdr"]
    role_name             = "Log Analytics Reader"
    scope = {
      display_name = "Tenant Root Group"
      type         = "management_group"
    }
  }
}
