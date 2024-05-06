/* consumption_budgets = {
  "test_subscription_budget" = {
    type       = "sub"
    amount     = 1000
    start_date = "2023-07-01T00:00:00Z"
    end_date   = "2024-07-01T00:00:00Z"
    notifications = {
      "notify_hunter_greaterthan_100" = {
        operator  = "GreaterThan"
        threshold = 100
        contact_emails = [
          "hunter.hawthorne@parsons.com"
        ]
        enabled = false
      }
    }
    dimensions = {
      "dimension_test" = {
        name = "ResourceGroupName"
        values = [
          "rg-cps-prod-01"
        ]
      }
    }
    tags = {
      "tag-test" = {
        name = "test"
        values = [
          "bar",
          "baz"
        ]
      }
    }
  },
  "test_resource_group_budget" = {
    type                = "rg"
    resource_group_name = "rg-cps-prod-01"
    amount              = 1000
    start_date          = "2023-07-01T00:00:00Z"
    end_date            = "2024-07-01T00:00:00Z"
    notifications = {
      "notify_hunter_greaterthan_100" = {
        operator  = "GreaterThan"
        threshold = 100
        contact_emails = [
          "hunter.hawthorne@parsons.com"
        ]
        enabled = false
      }
    }
  }
}
 */
