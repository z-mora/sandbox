consumption_budgets = {
  "monthly-spend" = {
    amount = 800
    notifications = {
      "actual" = {
        contact_emails = [
          "adam.chandler@parsons.com",
          "david.vanotterdyk@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Actual"
      }
      "forecasted" = {
        contact_emails = [
          "adam.chandler@parsons.com",
          "david.vanotterdyk@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Forecasted"
      }
    }
    start_date = "2023-11-01T00:00:00Z"
    type       = "sub"
  }
}
