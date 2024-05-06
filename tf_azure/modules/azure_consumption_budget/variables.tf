variable "amount" {
  type        = number
  description = "dollar amount the budget should be set to"
}

variable "consumption_budget_name" {
  type        = string
  description = "key value of each consumption budget, used to name the budget"
}

variable "dimensions" {
  type = map(object({
    name     = string
    operator = optional(string)
    values   = list(string)
  }))
  description = "consumption budget dimension"
  default     = {}
}

variable "end_date" {
  type        = string
  description = "end date for the budget"
  default     = null
}

variable "management_group_name" {
  type        = string
  description = "the name of the management group the budget will be applied to"
  default     = null
}

variable "notifications" {
  type = map(object({
    contact_emails = optional(list(string), null)
    contact_groups = optional(list(string), null)
    contact_roles  = optional(list(string), null)
    enabled        = optional(bool)
    operator       = string
    threshold      = number
    threshold_type = optional(string, null)
  }))
  description = "notifications for the consumption budget"
}

variable "resource_group_name" {
  type        = string
  description = "the name of the resource group the budget will be applied to"
  default     = null
}

variable "start_date" {
  type        = string
  description = "start date for the budget"
}

variable "tags" {
  type = map(object({
    name     = string
    operator = optional(string)
    values   = list(string)
  }))
  description = "consumption budget tags"
  default     = {}
}

variable "time_grain" {
  type        = string
  description = "time grain (monthly, annually, etc) used by the consumption budget"
}

variable "type" {
  type        = string
  description = "the type of consumption budget (subscription {sub}, management group {mg}, or resource group {rg})"
}
