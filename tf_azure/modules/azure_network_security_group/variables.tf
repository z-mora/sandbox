variable "flowlogs_enable" {
  type        = bool
  description = "Boolean flag to enable NSG Flowlogs"
  default     = "false"
}

variable "flowlogs_resource_group_name" {
  type        = string
  description = "Resource Group name destination for NSG Flowlogs"
}

variable "flowlogs_retention_days" {
  type        = number
  description = "Number of days to retain FlowLog records"
  default     = 7
}

variable "flowlogs_storageaccount_id" {
  type        = string
  description = "Storage account id destination for NSG Flowlogs"
}

variable "flowlogs_subscription_id" {
  type        = string
  description = "Subscription id destination for NSG Flowlogs"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "eastus2"
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
  description = "Network security group name"
}

variable "network_watcher_resource_group" {
  type        = string
  description = "Resource Group name of the network watcher RG"
  default     = "NetworkWatcherRG"
}

variable "network_watcher_name" {
  type        = string
  description = "Name of the Network Watcher"
}

variable "rules" {
  type = map(object({
    access                     = string
    description                = string
    destination_address_prefix = string
    destination_port_range     = string
    direction                  = string
    priority                   = number
    protocol                   = string
    source_address_prefix      = string
    source_port_range          = string
  }))
  description = "Object map of network security rules"
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
  description = "resource group name"
}
