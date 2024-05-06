variable "api_permissions" {
  type        = map(list(string))
  default     = {}
  description = <<-EOL
  A collection of API permissions to add for the app registration. They key should be
  the API/resource name and the value should be the permission scopes needed.
  For Microsoft Graph specifically, see:
  https://learn.microsoft.com/en-us/graph/permissions-reference
  Vendors should list permission requirements. You can also use the portal to see
  what's available.
  EOL
}

variable "certificates" {
  default     = {}
  description = "A collection of public client certificates to add for authentication"
  type = map(object({
    encoding          = optional(string, "pem")
    end_date          = optional(string)
    end_date_relative = optional(string)
    type              = string
    value             = string
  }))
}

variable "display_name" {
  type        = string
  description = "The display name for the application"
}

variable "secrets" {
  type = map(object({
    auto_rotate_days  = optional(number)
    end_date_relative = optional(string)
    staggered_rotation = optional(object({
      overlap_days = optional(number, 10)
      rotate_days  = number
    }))
    vault = optional(object({
      mount = string
      path  = string
    }))
  }))
  default     = {}
  description = <<-EOL
  A collection of client secrets (passwords) to be created for the app. The value for
  `auto_rotate_days` must not be greater than 180 to be compliant with Parsons' security
  policies. If you choose to store an access key in vault, any existing key at that path
  will be overwritten.
  EOL

  validation {
    condition = alltrue([
      for v in var.secrets : !anytrue([
        for x in ["\\", "-", "value", "key", "secret"] :
        strcontains(v.vault.path, x)
      ]) if v.vault != null
    ])
    error_message = "An unsupported value was found in the provided vault path"
  }

  validation {
    condition = alltrue([
      for v in var.secrets : v.vault == null ? true : !anytrue([
        startswith(v.vault.mount, "/"),
        endswith(v.vault.mount, "/"),
        startswith(v.vault.path, "/"),
        endswith(v.vault.path, "/"),
      ])
    ])
    error_message = "Vault mount and path should not start or end with '/'"
  }

  validation {
    condition     = alltrue([for v in var.secrets : try(v.auto_rotate_days <= 180, true)])
    error_message = "Client secrets cannot live longer than 180 days"
  }

  validation {
    condition = alltrue([
      for s in var.secrets : anytrue([
        (s.auto_rotate_days != null && s.end_date_relative == null && s.staggered_rotation == null),
        (s.auto_rotate_days == null && s.end_date_relative != null && s.staggered_rotation == null),
        (s.auto_rotate_days == null && s.end_date_relative == null && s.staggered_rotation != null)
      ])
    ])
    error_message = <<-EOL
    Must use `auto_rotate_days`, `end_date_relative`, & `staggered_rotation`
    exclusively from one another.
    EOL
  }
}

variable "web" {
  type = object({
    homepage_url = optional(string)
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool, false)
      id_token_issuance_enabled     = optional(bool, false)
    }))
    logout_url    = optional(string)
    redirect_uris = optional(list(string))
  })
  default     = null
  description = "An optional web block to configure web related settings for the app"
}
