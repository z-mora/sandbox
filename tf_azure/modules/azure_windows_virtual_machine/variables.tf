variable "backup" {
  type = object({
    policy_id           = string
    recovery_vault_name = string
  })
  description = <<-EOL
  If the VM should be backed up, specify the name of a recovery services vault and the
  ID of one of its backup policies to use. IF the VM should not be backed up, omit this
  variable.
  EOL
  default     = null
}

variable "disk_size_gb" {
  description = "The size of the internal OS disk in GB"
  type        = number
  default     = "80"
}

variable "domain_join_build_script" {
  type        = string
  description = "base64 byte string of build script"
}

variable "domain_join" {
  type        = bool
  description = "whether to domain join the VM"
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the key vault used for disk encryption"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "eastus2"
}

variable "managed_disks" {
  type = map(object({
    create_option        = string
    disk_size_gb         = number
    lun                  = number
    storage_account_type = string
    tier                 = string
    zone                 = number
  }))
  description = "Object map of Managed Disks"
  default     = {}
}

variable "network_interfaces" {
  type = map(object({
    enable_accelerated_networking = bool
    enable_ip_forwarding          = bool
    private_ip_address_allocation = string
    subnet_key                    = string
  }))
  description = "Object map of Network Interfaces"
  default     = {}
}

variable "private_subnets" {
  type = map(object({
    id = string
  }))
  description = "Private Subnets"
}

variable "required_tags" {
  type = object({
    App           = string
    Domain        = optional(string)
    EC2Scheduler  = optional(string)
    Environment   = string
    GBU           = string
    ITSM          = optional(string, "SERVER")
    JobWbs        = string
    Notes         = optional(string)
    Owner         = string
    SnapshotDaily = optional(string)
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

variable "size" {
  type        = string
  description = "The SKU for this Virtual Machine size"
}

variable "sku" {
  type        = string
  description = "SKU of the OS image used to create the Virtual Machines"
}

variable "storage_account_type" {
  type        = string
  description = "The type of Storage Account that should back this internal OS disk"
}

variable "timezone" {
  type        = string
  description = "The timezone in which this VM resides"
}

variable "virtual_machine_name" {
  type        = string
  description = "Virtual Machine name"
}

variable "zone" {
  type        = number
  description = "The Availability Zone which this Windows VM is located"
  default     = 1
}
