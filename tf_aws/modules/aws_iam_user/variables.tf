variable "access_keys" {
  type = map(object({
    auto_rotate_days = optional(number)
    staggered_rotation = optional(object({
      overlap_days = optional(number, 10)
      rotate_days  = number
    }))
    status = optional(string, "Active")
    vault = optional(object({
      mount = string
      path  = string
    }))
  }))
  default     = {}
  description = <<-EOL
  A collection of IAM access keys to create. The value for `auto_rotate_days` must not
  be greater than 180 to be compliant with Parsons' security policies. If you choose to
  store an access key in vault, any existing key at that path will be overwritten.
  EOL

  validation {
    condition = alltrue([
      for v in var.access_keys : !anytrue([
        for x in ["\\", "-", "value", "key", "secret"] :
        strcontains(v.vault.path, x)
      ]) if v.vault != null
    ])
    error_message = "An unsupported value was found in the provided vault path"
  }

  validation {
    condition = alltrue([
      for v in var.access_keys : v.vault == null ? true : !anytrue([
        startswith(v.vault.mount, "/"),
        endswith(v.vault.mount, "/"),
        startswith(v.vault.path, "/"),
        endswith(v.vault.path, "/"),
      ])
    ])
    error_message = "Vault mount and path should not start or end with '/'"
  }

  validation {
    condition     = alltrue([for v in var.access_keys : try(v.auto_rotate_days <= 180, true)])
    error_message = "Access keys cannot live longer than 180 days"
  }

  validation {
    condition = alltrue([
      for k in var.access_keys : anytrue([
        (k.auto_rotate_days != null && k.staggered_rotation == null),
        (k.auto_rotate_days == null && k.staggered_rotation != null),
        (k.auto_rotate_days == null && k.staggered_rotation == null)
      ])
    ])
    error_message = "Must use `auto_rotate_days` & `staggered_rotation` exclusively from one another"
  }
}

variable "groups" {
  type        = map(string)
  default     = {}
  description = <<-EOL
  A map of groups to add the user to. The key is the key of the group and the
  value is the group name.
  EOL
}

variable "name" {
  type        = string
  description = <<-EOL
  The user's name. The name must consist of upper and lowercase alphanumeric characters
  with no spaces. You can also include any of the following characters: =,.@-_.. User
  names are not distinguished by case. For example, you cannot create users named both
  "TESTUSER" and "testuser".
  EOL
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the user."
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
