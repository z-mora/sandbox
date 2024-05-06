variable "auto_inflate_enabled" {
  type        = bool
  description = "Boolean flag to specify whether the throughput units of a Standard SKU namespace can auto-inflate"
  default     = false
}

variable "capacity" {
  type        = number
  description = "Specifies the throughput units for a Standard SKU namespace.  Default is 2."
  default     = "2"
}

variable "eventhub_namespace_name" {
  type        = string
  description = "Eventhub Namespace name"
}

variable "eventhubs" {
  type = map(object({
    message_retention = number
    partition_count   = number
  }))
  description = "Object map of Eventhubs"
  default     = {}
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "eastus2"
}

variable "maximum_throughput_units" {
  type        = number
  description = "Maximum throughput units when auto-inflate is enabled.  Valid values are 1-20"
  default     = "10"
}

variable "required_tags" {
  type = object({
    App         = string
    Environment = string
    GBU         = string
    ITSM        = optional(string, "STORAGE")
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

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "sku" {
  type        = string
  description = "Tier of Eventhub Namespace.  Valid options are Basic, Standard and Premium"
  default     = "Standard"

  validation {
    condition = (
      lower(var.sku) == "basic" || lower(var.sku) == "standard" || lower(var.sku) == "premium"
    )
    error_message = "Input for Eventhub Namespace sku is invalid. Options are 'Basic', 'Standard', or 'premium'."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Allow/Disallow public network access to the Storage Account"
  default     = false
}
