variable "group_display_names" {
  default     = []
  description = "The display name of groups to assign to the role"
  type        = set(string)
}

variable "managed_identity_ids" {
  default     = {}
  description = <<-DESCRIPTION
  The ID of managed identities to assign to the role. The key is the key of the managed
  identity and the value is the ID.
  DESCRIPTION
  type        = map(string)
}

variable "role" {
  description = <<-DESCRIPTION
  The role that will be assigned. `name` is the name of a built-in or custom role.
  `id` is only here so an implicity dependency can be created with the `azure_role`
  module.
  DESCRIPTION
  type = object({
    id   = optional(string)
    name = string
  })
}

variable "scope" {
  description = <<-DESCRIPTION
  The scope where the role will be assigned. Must provide either `id` or both
  `display_name` and `type`. Scope `type` can either be `management_group`,
  `resource_group`, or `subscription`.
  DESCRIPTION
  type = object({
    display_name = optional(string)
    id           = optional(string)
    type         = optional(string)
  })

  validation {
    condition = (
      (var.scope.id == null && (var.scope.display_name != null && var.scope.type != null))
      ||
      (var.scope.id != null && (var.scope.display_name == null && var.scope.type == null))
    )
    error_message = "Must provide either `id` or both `display_name` and `type`."
  }

  validation {
    condition = try(
      contains(["management_group", "resource_group", "subscription"], var.scope.type),
      true
    )
    error_message = "`scope_type` must be `management_group`, `resource_group`, or `subscription`"
  }
}

variable "service_principal_ids" {
  default     = {}
  description = <<-DESCRIPTION
  The ID of service principals to assign to the role. The key is the key of the app
  registration and the value is the ID of the service principal associated with it.
  DESCRIPTION
  type        = map(string)
}

variable "user_principal_names" {
  default     = []
  description = "The UPN of users to assign to the role"
  type        = set(string)
}
