variable "backup_policies_workloads" {
  type = map(object({
    protection_policies = map(object({
      backup = object({
        frequency = string
        time      = string
      })
      policy_type = string
      retention_daily = object({
        count = number
      })
    }))
    resource_group_name = string
    settings = object({
      time_zone           = string
      compression_enabled = bool
    })
    workload_type = string
  }))
  description = "backup policies for non-VM workloads"
  default     = {}
}

variable "backup_policies" {
  type = map(object({
    backup = object({
      frequency = string
      time      = string
    })
    resource_group_name = string
    retention_daily = object({
      count = number
    })
    retention_monthly = object({
      count    = number
      weekdays = list(string)
      weeks    = list(string)
    })
    retention_weekly = object({
      count    = number
      weekdays = list(string)
    })
    retention_yearly = object({
      count    = number
      months   = list(string)
      weekdays = list(string)
      weeks    = list(string)
    })
  }))
  description = "map of backup policies"
  default     = {}
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "eastus2"
}

variable "name" {
  type        = string
  description = "Name of the Recovery Services Vault"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "enabled public network access to the Recovery services vaults"
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group the Recovery services vault will go in"
}

variable "sku" {
  type        = string
  description = "sku of the Recovery Services Vault"
}

variable "soft_delete_enabled" {
  type        = bool
  description = "Turn on soft delete for the backups created (keeps for 14 days after deletion)"
}

variable "required_tags" {
  type = object({
    App         = string
    Environment = string
    GBU         = string
    ITSM        = optional(string, "BACKUP")
    JobWbs      = string
    Notes       = optional(string)
    Owner       = string
  })
  description = "Required Azure tags"

  validation {
    condition     = contains(["DEV", "DR", "PROD", "QA", "TEST"], var.required_tags.Environment)
    error_message = "Environment tag must be one of: DEV, TEST, QA, PROD, DR"
  }

  validation {
    condition     = contains(["COR", "FED", "INF", "MEA"], var.required_tags.GBU)
    error_message = "GBU tag must be one of: COR, FED, INF, MEA"
  }

  validation {
    condition = contains(
      ["BACKUP", "DATABASE", "MANAGEMENT", "NETWORK", "SERVER", "STORAGE"],
      var.required_tags.ITSM
    )
    error_message = "ITSM tag must be one of: BACKUP, DATABASE, MANAGEMENT, NETWORK, SERVER, STORAGE"
  }

  validation {
    condition     = can(regex("^\\d{6}-\\d{5}$", var.required_tags.JobWbs))
    error_message = "JobWbs tag must be digits in the format xxxxxx-xxxxx"
  }

  validation {
    condition     = can(regex("(?i)[A-Z0-9+_.-]+@[A-Z0-9.-]+", var.required_tags.Owner))
    error_message = "Owner tag must be a valid email address"
  }
}
