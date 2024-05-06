variable "backend_pool_addresses" {
  type = map(object({
    backend_ip_address        = string
    backend_pool_address_name = string
  }))
  description = "Map of objects for load balancer backend pool addresses"
  default     = {}
}

variable "backend_pool_name" {
  type        = string
  description = "Name of the load balancer backend pool"
}

variable "frontend_name" {
  type        = string
  description = "Name of the frontend ip configuration"
}

variable "frontend_subnet" {
  type        = string
  description = "Name of the frontend ip configuration subnet"
}

variable "internal_or_external" {
  type        = string
  description = "Is this an internal or external load balancer?"
  default     = "internal"

  validation {
    condition = (
      lower(var.internal_or_external) == "internal" || lower(var.internal_or_external) == "external"
    )
    error_message = "Input for load balancer internal_or_external is invalid. Options are 'internal' and 'external'."
  }
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the load balancer"
}

variable "load_balancer_rules" {
  type = map(object({
    backend_port          = number
    disable_outbound_snat = bool
    enable_floating_ip    = bool
    enable_tcp_reset      = bool
    frontend_port         = number
    idle_timeout          = number
    load_distribution     = string
    probe_interval        = number
    probe_name            = string
    probe_number          = number
    probe_port            = number
    probe_protocol        = string
    probe_request_path    = string
    protocol              = string
  }))
  description = "Map of objects for load balancer rules"
  default     = {}
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

variable "public_ip_name" {
  type        = string
  description = "Name of the public ip for the frontend ip configuration. Only valid for external load balancers."
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

variable "sku" {
  type        = string
  description = "Type of load balancer"
  default     = "Standard"

  validation {
    condition = (
      lower(var.sku) == "basic" || lower(var.sku) == "standard" || lower(var.sku) == "gateway"
    )
    error_message = "Input for load balancer sku is invalid. Options are 'Basic', 'Standard', or 'Gateway'."
  }
}

variable "subscription_id" {
  type        = string
  description = "ID for the Azure subscription"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network associated with the backend pool address"
}

variable "zones" {
  type        = list(number)
  default     = null
  description = "A list of Availability Zones which the Load Balancer's IP Addresses should be created in."
}
