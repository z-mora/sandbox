locals {
  backup_policies_retention_periods = { for k, policy in var.backup_policies : k => {
    retention_daily_exists   = (policy.retention_daily != null),
    retention_monthly_exists = (policy.retention_monthly != null),
    retention_weekly_exists  = (policy.retention_weekly != null),
    retention_yearly_exists  = (policy.retention_yearly != null),
  } }
}
