role_assignments = {
  "Grant users access to sub" = {
    role_name = "role-parsons-alz-admin"
    scope = {
      display_name = "sub-comm-fed-ai-01"
      type         = "subscription"
    }
    user_principal_names = [
      "a0064183@Parsons.com", # Mark Neitzschman
      "Kyle.Braaten_parsons.us#EXT#@parsons365.onmicrosoft.com",
      "David.Boyd_parsons.us#EXT#@parsons365.onmicrosoft.com",
      "David.Tong_parsons.us#EXT#@parsons365.onmicrosoft.com",
    ]
  }
}
