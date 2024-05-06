variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "dhcp_options" {
  type = object({
    domain_name         = string
    domain_name_servers = optional(list(string), [])
    # Type = set so for_each can be used
    resolver_rule_ids = optional(set(string), [])
  })
  default     = null
  description = <<EOL
  DNS options which are used to create a DHCP options set and attach it to the VPC.
  If the object is null, the default DHCP option set is used. If domain_name_servers is
  omitted, AmazonProvidedDNS is used and resolver_rule_ids must be specified.
  resolver_rule_ids cannot be used with domain_name_servers. resolver_rule_ids should
  be a list of existing Route 53 Resolver Rules to associate to the VPC.
  EOL

  validation {
    condition = (
      var.dhcp_options == null ? true : alltrue([
        for ip in var.dhcp_options.domain_name_servers :
        can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", ip))
      ])
    )
    error_message = "domain_name_servers must be a list containing IPs."
  }

  validation {
    condition = (
      var.dhcp_options == null ? true : (
        (length(var.dhcp_options.resolver_rule_ids) > 0 &&
        length(var.dhcp_options.domain_name_servers) == 0)
        ||
        (length(var.dhcp_options.domain_name_servers) > 0 &&
        length(var.dhcp_options.resolver_rule_ids) == 0)
      )
    )
    error_message = "Resolver rule IDs must be provided only if using AmazonProvidedDNS"
  }
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "flowlog_retention_days" {
  type        = number
  default     = 30
  description = "Retention in days for VPC flow logs"
}

variable "flowlog_traffic_type" {
  type        = string
  default     = "ALL"
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL"
}

variable "instance_tenancy" {
  type        = string
  default     = "default"
  description = "A tenancy option for instances launched into the VPC. Options are default or dedicated"
}

variable "is_gov" {
  type        = bool
  description = "If the current AWS partition is GovCloud"
}

variable "private_subnets" {
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
  description = "Map of private subnets to create in the VPC"
}

variable "subnet_res_cidr_desc" {
  type = string
  description = "The purpose of the reservation"
}

variable "subnet_res_cidr_block" {
  type = number
  description = "Subnet CIDR Reservation"
}

variable "region" {
  type        = string
  description = "AWS region"
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
  type        = string
  description = "The ID of the transit gateway to attach and route traffic to"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}
