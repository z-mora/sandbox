role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-inf-ipkeys-test-01"
      type         = "subscription"
    }
    user_principal_names = [
      "brian.watson@parsons.com",
      "ingrid.palmieri@parsons.com",
      "mark.ponder@parsons.com",
    ]
  }
}
