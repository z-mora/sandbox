variable "account_id" {
  type        = string
  description = "The ID of the account where the IdP and role will be deployed"
}

variable "account_name" {
  type        = string
  description = <<-EOL
  The name of the account to add as a prefix to the role name. For example, if
  the account name is is "pce-fed-mtc-epoch1-dev", the role name would be
  `pce-fed-mtc-epoch1-dev-ADMIN-Role`
  EOL
}

variable "is_gov" {
  type        = bool
  description = "If the current account is in gov or not"
}

variable "partition" {
  type        = string
  description = "The current AWS partition"
}

variable "roles" {
  description = <<-EOL
  The roles & policies that will be created for the parons.us users to use.
  `account-admin` is typically what's provided to users.
  `full_admin` may be required in some exceptions, which allows everything.
  `billing` only allows billing & support related actions, which is likely only necessary
  if granting access to a GovCloud parent account.
  EOL
  type        = set(string)

  validation {
    condition = alltrue([for role in var.roles : contains([
      "account-admin",
      "billing",
      "ctf-limited",
      "full-admin",
      "route53-parsons-cyber",
      "route53-parsons-games",
    ], role)])
    error_message = "`role` must be a supported value"
  }
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
