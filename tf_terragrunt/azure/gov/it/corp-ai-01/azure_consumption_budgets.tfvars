consumption_budgets = {
  "monthly-spend" = {
    amount = 5000
    notifications = {
      "actual" = {
        contact_emails = [
          "mark.neitzschman@parsons.com",
          "karen.wright@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Actual"
      }
      "forecasted" = {
        contact_emails = [
          "mark.neitzschman@parsons.com",
          "karen.wright@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Forecasted"
      }
    }
    start_date = "2024-02-01T00:00:00Z"
    type       = "sub"
  }
}
