variable "bgp_asn" {
  type        = number
  description = "The gateway's BGP ASN"
}

variable "name" {
  type        = string
  description = "A name for the customer gateway device"
}

variable "ip_address" {
  type        = string
  description = "The IPv4 address for the customer gateway device's outside interface"
}

variable "tags" {
  nullable = false
  type = object({
    App         = optional(string)
    Environment = optional(string)
    GBU         = optional(string)
    ITSM        = optional(string, "NETWORK")
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

variable "vpn_connections" {
  type = map(object({
    transit_gateway_id = string
  }))
  description = "value"
}
