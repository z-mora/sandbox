consumption_budgets = {
  "monthly-spend" = {
    amount = 1000
    notifications = {
      "actual" = {
        contact_emails = [
          "adam.chandler@parsons.com",
          "jason.small@parsons.com",
          "Derek.Pines@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Actual"
      }
      "forecasted" = {
        contact_emails = [
          "adam.chandler@parsons.com",
          "jason.small@parsons.com",
          "Derek.Pines@parsons.com"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Forecasted"
      }
    }
    start_date = "2024-03-01T00:00:00Z"
    type       = "sub"
  }
}
