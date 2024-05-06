role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-ci-itd-its-dev-02"
      type         = "subscription"
    }
    user_principal_names = [
      "adam.chandler@parsons.com",
      "bc.smith@parsons.com",
      "david.vanotterdyk@parsons.com",
    ]
  }
}
