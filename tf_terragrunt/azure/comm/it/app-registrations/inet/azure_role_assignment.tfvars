role_assignments = {
  "inet-security-reader" = {
    app_registration_keys = [
      "_sys_inet_secureframe",
    ]
    role_name = "Security Reader"
    scope = {
      display_name = "mg-inet-01"
      type         = "management_group"
    }
  }
  "inet-log-analytics-reader" = {
    app_registration_keys = [
      "_sys_inet_secureframe",
    ]
    role_name = "Log Analytics Reader"
    scope = {
      display_name = "mg-inet-01"
      type         = "management_group"
    }
  }
}
