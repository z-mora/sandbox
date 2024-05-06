role_assignments = {
  "owner" = {
    app_registration_keys = ["_sys_terragrunt_admin"]
    role_name             = "Owner"
    scope = {
      display_name = "Tenant Root Group"
      type         = "management_group"
    }
  }
}
