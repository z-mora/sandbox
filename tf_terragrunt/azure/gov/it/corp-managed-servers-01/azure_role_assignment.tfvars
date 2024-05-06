role_assignments = {
  "Grant owner access to sub" = {
    role_name = "Owner"
    scope = {
      display_name = "sub-gov-corp-managed-servers-01"
      type         = "subscription"
    }
    user_principal_names = [
      "a009049D@parsons.us", # David Schramm
      "javier-adminA.mora@parsons.us",
    ]
  }
}
