variable "cidr" {
  type        = list(string)
  description = "The CIDR block for the virtual network"
  default     = []
}

variable "dns_servers" {
  type        = list(string)
  description = "This is the DNS local IP that will be used as the DNS IP in the virtual_network"
  default     = null
}

variable "gateway_subnet_address_prefix" {
  type        = list(string)
  description = "address prefix of virtual network Gateway Subnet"
  default     = null
}

variable "is_gov" {
  description = "Is the deployment running within a Azure US Government tenant"
  type        = bool
}

variable "is_dmz" {
  type        = bool
  default     = null
  description = <<-EOL
  Is the VNet a DMZ. All business unit or project VNets are DMZs. If true, peer the VNet
  to the corporate Palo Alto VNet and create a virtual hub route. If false, connect the
  VNet to the corporate virtual WAN hub in the same region. If null, establish no
  connectivity.
  EOL
}

variable "link_dns_hub_forwarding_ruleset" {
  default     = false
  description = <<-DESCRIPTION
  If the VNet should be linked to the DNS hub's centralized forwarding ruleset. If it's
  linked, the DNS hub will be used for resolving DNS queries for Azure resources.
  DESCRIPTION
  type        = bool
}

variable "location" {
  type        = string
  description = "Name of the Azure region"
}

variable "monitor_diagnostic_destinations" {
  type = object({
    eventhubs = map(object({ # key = region
      authorization_rule_id = string
      eventhub_name         = string
      namespace_name        = string
    }))
    log_analytics_workspace_id = string
    resource_group_name        = string
    subscription_id            = string
  })
  description = <<-EOL
  Destinations used by azurerm_monitor_diagnostic_setting to store activity logs in a
  central location. The log analytics workspace doesn't have to be in the same region as
  the resource. The eventhub does have to be in the same region as the resource, so they
  are stored in a map where the key is the region.
  EOL
}

variable "name" {
  type        = string
  description = "Name of the virtual_network"
}

variable "private_subnets" {
  type = map(object({
    address_prefixes                              = list(string)
    delegation_actions                            = optional(list(string))
    delegation_name                               = optional(string)
    delegation_service                            = optional(string)
    network_security_group_id                     = string
    private_endpoint_network_policies_enabled     = optional(bool, false)
    private_link_service_network_policies_enabled = optional(bool, false)
    route_table_id                                = optional(string)
    route_table_key                               = optional(string)
    service_endpoints                             = optional(list(string))

  }))
  description = <<-EOL
  Collection of private subnets to create. If service endpoints aren't specified, it
  will automatically use the list defined in locals.tf.
  EOL
  default     = {}
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
