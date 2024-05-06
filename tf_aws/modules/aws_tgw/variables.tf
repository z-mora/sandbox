variable "amazon_side_asn" {
  type        = number
  description = <<EOL
  Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range
  is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs.
  EOL
  default     = 64512
}
variable "auto_accept_shared_attachments" {
  type        = bool
  description = "Whether resource attachment requests are automatically accepted."
  default     = false
}

variable "cidr_blocks" {
  type        = list(string)
  default     = null
  description = <<-EOL
  One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR
  block or larger for IPv4, or a size /64 CIDR block or larger for IPv6.
  EOL
}

variable "default_route_table_association" {
  type        = bool
  description = "If attachments are automatically associated with the default association route table."
  default     = false
}

variable "default_route_table_propagation" {
  type        = bool
  description = "Whether resource attachments automatically propagate routes to the default propagation route table."
  default     = false
}

variable "description" {
  type        = string
  description = "Description of the EC2 Transit Gateway"
}

variable "dns_support" {
  type        = bool
  description = "Whether DNS support is enabled"
  default     = true
}

variable "name" {
  type        = string
  description = "The name of the transit gateway"
}

variable "share_to_principals" {
  type        = set(string)
  default     = []
  description = <<-EOL
  A set of principals to share the transit gateway with by using the Resource Access
  Manager service. Possible values are an AWS account ID, an AWS Organizations
  Organization ARN, or an AWS Organizations Organization Unit ARN.
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

variable "vpn_ecmp_support" {
  type        = bool
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  default     = true
}
