role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-ci-itd-its-prod-01"
      type         = "subscription"
    }
    user_principal_names = [
      "david.d.jansen@parsons.com",
      "david.gaarsoe@parsons.com",
      "derrick.dean@parsons.com",
    ]
  }
}
