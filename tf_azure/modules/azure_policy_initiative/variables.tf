variable "assignments" {
  default     = {}
  description = <<DESCRIPTION
  Optional assignments to assign the policy initiative to management groups or
  subscriptions.
  DESCRIPTION
  type = map(object({
    description = optional(string)
    enforce     = optional(bool, true)
    identity = optional(object({
      identity_ids = optional(list(string))
      type         = string
    }))
    location   = optional(string, "eastus2")
    scope_type = string
    exemptions = optional(map(object({
      category     = string
      description  = optional(string)
      display_name = string
      scope_type   = string
    })), {})
  }))

  validation {
    condition = alltrue([
      for k, v in var.assignments :
      try(v.identity.type == "UserAssigned", true) ? v.identity.identity_ids != null : true
    ])
    error_message = "`identity_ids` must be set if identity is `UserAssigned`"
  }

  validation {
    condition = alltrue([
      for k, v in var.assignments :
      contains(["management_group", "subscription"], v.scope_type)
    ])
    error_message = "`scope_type` must be `management_group` or `subscription`"
  }

  validation {
    condition = alltrue([
      for k, v in var.assignments : (
        v.scope_type == "subscription" && length(v.exemptions) > 0 ? false : true
      )
    ])
    error_message = "Exemptions not supported for `subscription` assignments"
  }
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the policy set definition."
}

variable "display_name" {
  type        = string
  description = <<-EOL
  The display name of the policy set definition. If not specified, this will be set to
  the name.
  EOL
}

variable "management_group_display_name" {
  type        = string
  default     = null
  description = <<-EOL
  The ID of the Management Group where this policy set definition should be defined.
  Changing this forces a new resource to be created.
  EOL
}

variable "metadata" {
  type        = map(any)
  default     = null
  description = "The metadata for the policy set definition, such as category."
}

variable "name" {
  type        = string
  description = "The name of the policy set definition. Changing this forces a new resource to be created."
}

variable "parameters" {
  type        = map(any)
  default     = null
  description = "Parameters for the policy set definition."
}

variable "policy_definition_groups" {
  type = map(object({
    category     = optional(string)
    description  = optional(string)
    display_name = optional(string)
  }))
  default     = {}
  description = <<-EOL
    Groups you can have created within the initiative to group the policy definitions
    that are added.
    EOL
}

variable "policy_definition_references" {
  type = map(object({
    definition_display_name = optional(string)
    parameters = optional(map(object({
      list_value   = optional(list(string))
      string_value = optional(string)
    })), {})
    reference_id       = optional(string)
    policy_group_names = optional(list(string))
  }))
  description = <<-EOL
    Existing policies to add to the initiative. They can be either custom or built-in.
    If any groups are specified, they must be defined in `policy_definition_groups`.
    The key must be an existing policy's `display_name`, so it can be looked up using a
    data source.

    `definition_display_name` is intended to be used if you'd like to add the same
    policy definition more than once. The map key still must be unique, so append
    something to the end such as the group ID or another reason for the duplicate policy.
    See the examples.

    > NOTE: `display_name` is not unique, so if there's more than 1 policy with the same
    > display name you will run into issues
    EOL

  validation {
    condition = alltrue([for ref_obj in var.policy_definition_references : alltrue([
      for param in ref_obj.parameters : (
        (param.list_value == null && param.string_value != null)
        ||
        (param.list_value != null && param.string_value == null)
      )
    ])])
    error_message = <<-MESSAGE
    If a policy definition reference object has `parameters` it must specify either
    `list_value` or `string_value`, but not both
    MESSAGE
  }
}
