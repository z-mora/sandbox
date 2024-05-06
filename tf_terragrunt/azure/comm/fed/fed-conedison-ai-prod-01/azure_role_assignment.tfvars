role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-fed-conedison-ai-prod-01"
      type         = "subscription"
    }
    user_principal_names = [
      "a008578G@parsons.com", # Hrishi Nulkar
      "a008747C@parsons.com", # Elissa Douglas
    ]
  }
}
