variable "custom_rules" {
  default     = {}
  description = <<-DESCRIPTION
  A collection of custom rules to be created in the forwarding ruleset. The key is the
  domain name (without a period at the end). Each target DNS server should be in the
  format "IP:port". This should only be used if you need to force resolution of a
  resource's public endpoint.
  DESCRIPTION
  type = map(object({
    enabled            = optional(bool, true)
    target_dns_servers = set(string)
  }))

  validation {
    condition     = !anytrue([for k, v in var.custom_rules : endswith(k, ".")])
    error_message = "The custom rule key must be a valid FQDN without a trailing period"
  }

  validation {
    condition = try(alltrue([
      for v in var.custom_rules : alltrue([
        for rule in v.target_dns_servers : can(tonumber(split(":", rule)[1]))
      ])
    ]), false)
    error_message = "The target DNS server must be in the format IP:port"
  }
}

variable "inbound_endpoint_ip" {
  description = <<-EOL
  The private IP of the DNS private resolver's inbound endpoint that DNS queries will be
  routed to. This will be the target DNS server for each of the rules.
  EOL
  type        = string
}

variable "location" {
  description = "The region where the forwarding ruleset will be created"
  type        = string
}

variable "name" {
  description = "The name of the forwarding ruleset"
  type        = string
}

variable "outbound_endpoint_id" {
  description = "The ID of the DNS private resolver's outbound endpoint"
  type        = string
}

variable "private_link_zone_names" {
  description = <<-EOL
  The list of private link zone names that exist in the DNS hub. Each zone will have a
  rule created in the ruleset.
  EOL
  type        = set(string)
}

variable "required_tags" {
  type = object({
    App         = string
    Environment = string
    GBU         = string
    ITSM        = optional(string, "NETWORK")
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
  description = "The resource group where the forwarding ruleset will be created"
  type        = string
}
