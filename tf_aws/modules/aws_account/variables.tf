variable "additional_alternate_contacts" {
  type = map(object({
    alternate_contact_type = string
    title                  = string
    email_address          = string
    phone_number           = string
  }))
  description = "Map of objects for account additional alternate contacts"
  default     = {}
}

variable "additional_sso_assignments" {
  type = map(object({
    instance_arn       = string
    target_type        = string
    permission_set_arn = string
    principal_type     = string
    principal_id       = string
  }))
  description = "Map of objects for additional account assignments that are optional"
  default     = {}
}

variable "admin_role_name" {
  type        = string
  description = <<-DOC
    The name of an IAM role that Organizations automatically preconfigures in the new
    member account. This role trusts the root account, allowing users in the root
    account to assume the role, as permitted by the root account administrator. The role
    has administrator permissions in the new member account.
  DOC
}

variable "common_alternate_contacts" {
  type = map(object({
    alternate_contact_type = string
    title                  = string
    email_address          = string
    phone_number           = string
  }))
  description = "Map of objects for common account alternate contacts"
  default     = {}
}

variable "common_sso_assignments" {
  type = map(object({
    instance_arn       = string
    target_type        = string
    permission_set_arn = string
    principal_type     = string
    principal_id       = string
  }))
  description = "Map of objects for common account assignments for all accounts"
  default     = {}
}

variable "create_govcloud" {
  type        = bool
  description = "Also creates a GovCloud account if true"
  default     = false
}

variable "email_address" {
  type        = string
  description = "AWS Account Email Address"
}

variable "name" {
  type        = string
  description = "Name of the AWS account"
}

variable "organization_id" {
  type        = string
  description = "The ID of the current organization"
}

variable "parent_ou_id" {
  type        = string
  description = "AWS Parent OU ID, this should be null for the org master account."
  default     = null
}

variable "tags" {
  nullable = false
  type = object({
    App         = optional(string)
    Environment = optional(string)
    GBU         = optional(string)
    ITSM        = optional(string, "MANAGEMENT")
    JobWbs      = optional(string)
    Notes       = optional(string)
    Owner       = optional(string)
  })
  default     = {}
  description = "Optional tags to override provider defaults"

  validation {
    condition = try(
      contains(["DEV", "DR", "PROD", "QA", "TEST"], var.tags.Environment),
      var.tags.Environment == null, var.tags == null
    )
    error_message = "Environment tag must be one of: DEV, TEST, QA, PROD, DR"
  }

  validation {
    condition = try(
      contains(["COR", "FED", "INF", "MEA"], var.tags.GBU),
      var.tags.GBU == null, var.tags == null
    )
    error_message = "GBU tag must be one of: COR, FED, INF, MEA"
  }

  validation {
    condition = try(
      contains(["BACKUP", "DATABASE", "MANAGEMENT", "NETWORK", "SERVER", "STORAGE"], var.tags.ITSM),
      var.tags.ITSM == null, var.tags == null
    )
    error_message = "ITSM tag must be one of: BACKUP, DATABASE, MANAGEMENT, NETWORK, SERVER, STORAGE"
  }
  validation {
    condition = (
      can(regex("^\\d{6}-\\d{5}$", var.tags.JobWbs)) ||
      can(var.tags.JobWbs == null) || var.tags == null
    )
    error_message = "JobWbs tag must be digits in the format xxxxxx-xxxxx"
  }

  validation {
    condition = (
      can(regex("(?i)[A-Z0-9+_.-]+@[A-Z0-9.-]+", var.tags.Owner)) ||
      can(var.tags.Owner == null) || var.tags == null
    )
    error_message = "Owner tag must be a valid email address"
  }
}
