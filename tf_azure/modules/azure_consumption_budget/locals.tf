locals {
  create_budget_filter = (var.dimensions != null || var.tags != null) ? true : false
}
