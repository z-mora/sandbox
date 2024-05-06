
variable "built_in_assignments" {
  type = map(object({
    description            = string
    enforce                = bool
    policy_definition_id   = string
    scope                  = string
    scope_id               = string
    parameters             = optional(string)
    metadata               = optional(string)
    location               = string
    identity_type          = string              # The type of identity to assign (e.g., 'UserAssigned' or 'SystemAssigned')
    identity_ids           = optional(list(any)) # List of identity IDs to assign (empty list for 'SystemAssigned')
    role_assignment_needed = bool
  }))
  description = "policy assignment set"

  validation {
    condition = alltrue([
      for k in var.built_in_assignments : contains(["r", "rg", "sub", "mg"], k.scope)
    ])
    error_message = "Valid scopes are r, rg, sub, or mg"
  }
  default = {}
}

variable "built_in_exemptions" {
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
      for k in var.built_in_exemptions : contains(["r", "rg", "sub", "mg"], k.scope)
    ])
    error_message = "Valid scopes are r, rg, sub, or mg"
  }
}

variable "role_definition_name" {
  type        = string
  description = "RBAC Role Name to be assigned to the Policy Assignment's Managed Identity for DINE and Modify Policy Remediation - e.g., Storage Account Contributor"
}
