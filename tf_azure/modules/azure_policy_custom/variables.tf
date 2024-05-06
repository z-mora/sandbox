variable "policy_assignments" {
  type = map(object({
    enforce         = bool
    initiative_name = string
    scope           = string
    scope_id        = string
  }))
  description = "policy assignment set"

  validation {
    condition = alltrue([
      for k in var.policy_assignments : contains(["r", "rg", "sub", "mg"], k.scope)
    ])
    error_message = "Valid scopes are r, rg, sub, or mg"
  }
}

variable "policy_exemptions" {
  type = map(object({
    assignment_name = string
    category        = string
    scope           = string
    scope_id        = string
  }))
  default     = {}
  description = <<EOL
  A map of resources, resource groups, subscriptions, or management groups to exclude
  from the specified policy assignment.
  EOL

  validation {
    condition = alltrue([
      for k in var.policy_exemptions : contains(["r", "rg", "sub", "mg"], k.scope)
    ])
    error_message = "Valid scopes are r, rg, sub, or mg"
  }
}

variable "initiative_definition_name" {
  type        = string
  description = "name of the policy initiative"
}
