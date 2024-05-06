role_assignments = {
  "inet-mgmt-group-admin-access" = {
    role_name = "role-parsons-alz-inet-admin"
    scope = {
      display_name = "mg-inet-01"
      type         = "management_group"
    }
    user_principal_names = [
      "a005002b@parsons.com", # Adam Chandler
      "a005449F@Parsons.com", # BC Smith
      "a005478b@parsons.com", # David VanOtterdyk
    ]
  }
  "inet-mgmt-group-billing-access" = {
    role_name = "Billing Reader"
    scope = {
      display_name = "mg-inet-01"
      type         = "management_group"
    }
    user_principal_names = [
      "carla.anguiano@parsons.com",
      "guada.casuso@parsons.com",
      "korina.moore@parsons.com",
      "valerie.williams@parsons.com",
    ]
  }
}
