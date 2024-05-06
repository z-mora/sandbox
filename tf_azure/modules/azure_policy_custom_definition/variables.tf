variable "description" {
  description = "description of the custom policy"
  type        = string
}

variable "display_name" {
  description = <<-DESCRIPTION
  The display name of the custom policy definition. This is what you'll see in the portal.
  DESCRIPTION
  type        = string
}

variable "metadata" {
  description = "Key value pairs of policy metadata that will be converted to a JSON string"
  type        = map(any)
}

variable "mode" {
  description = <<-DESCRIPTION
  The policy resource manager mode that allows you to specify which resource types will
  be evaluated. For possible values, see:
  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#mode
  DESCRIPTION
  type        = string
}

variable "name" {
  description = "Name of the custom policy"
  type        = string
}

variable "management_group_id" {
  description = "management group id where this custom policy will reside"
  type        = string
}

variable "parameters" {
  description = "Policy parameters that will be converted to a JSON string"
  type = map(object({
    allowedValues = optional(list(string))
    defaultValue  = optional(string)
    type          = string
    metadata = optional(object({
      assignPermissions = optional(bool)
      description       = optional(string)
      displayName       = optional(string)
      strongType        = optional(string)
    }))
  }))
}

variable "policy_rule" {
  description = "JSON string of the policy definition"
  type        = string
}
