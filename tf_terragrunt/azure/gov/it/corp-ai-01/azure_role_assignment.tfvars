role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-gov-corp-ai-01"
      type         = "subscription"
    }
    user_principal_names = [
      "a001056H@parsons.us", # David Boyd
      "a001275H@parsons.us", # Michael Daconta
      "Mark-AdminG.Neitzschman@parsons.us",
      "Michael.Daconta@parsons.us",
    ]
  }
}
