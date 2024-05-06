variable "allow_branch_to_branch_traffic" {
  type        = bool
  description = "Boolean flag to specify whether branch to branch traffic is allowed"
  default     = true
}

variable "disable_vpn_encryption" {
  type        = bool
  description = "Boolean flag to specify whether VPN encyption is enabled or disabled"
  default     = false
}

variable "location" {
  type        = string
  description = "Name of the Azure region"
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
  type        = string
  description = "Name of the resource group"
}

variable "subscription_id" {
  type        = string
  description = "ID for the Azure subscription"
}

variable "type" {
  type        = string
  description = "The virtual WAN type"
  default     = "Standard"

  validation {
    condition = (
      lower(var.type) == "standard"
    )
    error_message = "Input for virtual WAN type is invalid. Option is 'Standard' only."
  }
}

variable "virtual_hubs" {
  type = map(object({
    instance_0_custom_ip        = list(string)
    instance_1_custom_ip        = list(string)
    internet_security_enabled   = bool
    location                    = string
    remote_virtual_network_name = string
    routing_preference          = string
    scale_unit                  = number
    virtual_hub_address_prefix  = string
    vpn_gateway_name            = string
  }))
  description = "Map of objects for virtual HUBs"
  default     = {}
}

variable "virtual_wan_name" {
  type        = string
  description = "Name of the virtual WAN"
}

variable "vpn_sites" {
  type = map(object({
    asn                  = number
    connection_link_name = string
    device_model         = string
    device_vendor        = string
    location             = string
    peering_address      = string
    provider_name        = string
    sa_data_size_kb      = number
    site_link_ip_address = string
    speed_in_mbps        = number
    virtual_hub_key      = string
    vpn_connection_name  = string
  }))
  description = "Map of objects for VPN connections"
  default     = {}
}
