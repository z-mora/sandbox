variable "name" {
  type        = string
  description = "The name of the transit gateway route table"
}

variable "organization_id" {
  type        = string
  description = "The ID of the current organization"
}

variable "override_blackhole_cidrs" {
  type        = set(string)
  default     = null
  description = <<-EOL
  A set of CIDRs to create blackhole routes for. Only use if you don't want to use the
  default CIDRs in `local.blackhole_cidrs`. Do not use with `transit_gateway_id`.
  EOL
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

variable "transit_gateway_id" {
  type        = map(string)
  default     = {}
  description = <<-EOL
  The ID of of the transit gateway that the route table is for. Should be used if you're
  creating an empty route table in a corporate account. Do not use with
  `tgw_vpc_attachment_ids`. The key should be the transit gateway key and the value
  should be the transit gateway ID. There should only be one item in the map. This must
  be a map so the keys will be known before apply.
  EOL
  nullable    = false
}

variable "tgw_vpc_attachment_ids" {
  type        = map(string)
  description = <<-EOL
  The transit gateway VPC attachment IDs of the BU VPCs in this region that you
  want to set up the route table for. Do not use with `transit_gateway_id`. The key
  should be the VPC key and the value should be the VPC's transit gateway attachment ID.
  This must be a map so the keys will be known before apply.
  EOL
  default     = {}
  nullable    = false
}
