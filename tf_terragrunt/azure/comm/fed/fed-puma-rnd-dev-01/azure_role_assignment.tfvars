role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-fed-puma-rnd-dev-01"
      type         = "subscription"
    }
    user_principal_names = [
      "brian.ngac@parsons.com",
      "garrett.youmans@parsons.com",
      "johnpaul.gurley@parsons.com",
      "nate.sposit@parsons.com",
      "stephen.thomas@parsons.com",
    ]
  }
}
