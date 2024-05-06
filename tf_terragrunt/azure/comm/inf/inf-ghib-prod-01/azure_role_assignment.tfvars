role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-inf-ghib-prod-01"
      type         = "subscription"
    }
    user_principal_names = [
      "bartosz.derbis@parsons.com",
      "chris.lapegna@parsons.com",
      "matthew.anderson@parsons.com",
    ]
  }
}
