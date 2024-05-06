role_assignments = {
  "Grant access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-corp-sap-poc-dev-01"
      type         = "subscription"
    }
    user_principal_names = [
      "craig.allen@parsons.com",
      "mike.karim@parsons.com",
    ]
  }
}
