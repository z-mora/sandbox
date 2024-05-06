role_assignments = {
  "Grant read access to sub" = {
    role_name = "Reader"
    scope = {
      display_name = "sub-comm-corp-netapp-test-01"
      type         = "subscription"
    }
    user_principal_names = [
      "atul.mishra@parsons.com",
    ]
  }
  "Grant bluexp connector creation to sub" = {
    role_name = "role-bluexp-connector-creation"
    scope = {
      display_name = "sub-comm-corp-netapp-test-01"
      type         = "subscription"
    }
    user_principal_names = [
      "a0079954@parsons.com", # Scott Graham
      "randy.johnson@parsons.com",
    ]
  }
}
