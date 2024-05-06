variable "current_account_id" {
  type        = string
  description = "The current account ID. Used to replace CloudFormation pseudo params"
}

variable "current_partition" {
  type        = string
  description = "The current AWS partition. Used to replace CloudFormation pseudo params"
}

variable "current_region" {
  type        = string
  description = "The current AWS region. Used to replace CloudFormation pseudo params"
}


variable "description" {
  type        = string
  default     = null
  description = "The description of the policy. If changed, will force recreation of the policy."
}

variable "name" {
  type        = string
  description = "The name of the policy. If changed, will force recreation of the policy."
}

variable "name_prefix" {
  type        = string
  description = <<-EOL
  Creates a unique name for the policy beginning with the specified prefix.
  If specified, will be used instead of `name`. If changed, will force recreation of the
  policy.
  EOL
  default     = null
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the policy."
}

variable "policy_hcl" {
  type = object({
    statements = map(object({
      actions   = optional(list(string))
      effect    = string
      resources = list(string)
      sid       = optional(string)
    }))
    version = optional(string, "2012-10-17")
  })
  description = <<-EOL
  The policy document, defined in HCL. Any `$` characters in the policy need to be
  escaped with another `$`. See README for info about CloudFormation psuedo params.
  EOL
  default     = null
}

variable "policy_yaml" {
  type        = string
  description = <<-EOL
  The policy document as a YAML string. This isn't the recommended approach. Any `$`
  characters in the policy need to be escaped with another `$`. See README for info
  about CloudFormation pseudo params.
  EOL
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
