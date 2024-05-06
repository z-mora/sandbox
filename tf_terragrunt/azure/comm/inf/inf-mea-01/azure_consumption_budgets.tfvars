consumption_budgets = {
  "monthly-spend" = {
    amount = 1000
    notifications = {
      "actual" = {
        contact_emails = [
          "michael.daconta@parsons.us",
          "david.boyd@parsons.us"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Actual"
      }
      "forecasted" = {
        contact_emails = [
          "michael.daconta@parsons.us",
          "david.boyd@parsons.us"
        ]
        enabled        = true
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Forecasted"
      }
    }
    start_date = "2024-01-01T00:00:00Z"
    type       = "sub"
  }
}

