variable "accelerated_networking" {
  description = <<-EOF
  Enable Azure accelerated networking (SR-IOV) for all network interfaces except the
  primary one (it is the PAN-OS management interface, which [does not support](
    https://docs.paloaltonetworks.com/pan-os/9-0/pan-os-new-features/virtualization-features/support-for-azure-accelerated-networking-sriov
  ) acceleration).
  EOF
  default     = true
  type        = bool
}

variable "app_insights_settings" {
  description = <<-EOF
  A map of the Application Insights related parameters.

  If the variable is:
  - not defined - Application Insights will not be created (default behavior)
  - defined as empty map `{}` - Application Insights will be created based on the default parameters
  - defined as a map - Application Insights will be created with the defined properties, for any skipped - a default value will be used.

  Available properties are:
  - `name`                      - (optional|string) Name of the Applications Insights
    instance. Can be `null`, in which case a default name is auto-generated.
  - `workspace_mode`            - (optional|bool)   Application Insights mode. If `true`
    (default), the "Workspace-based" mode is used. With `false`, the mode is set to legacy "Classic".
  - `metrics_retention_in_days` - (optional|number) Specifies the retention period in days.
    Possible values are 0, 30, 60, 90, 120, 180, 270, 365, 550 or 730. Azure defaults is 90.
  - `log_analytics_name`        - (optional|string) The name of the Log Analytics workspace.
    Can be `null`, in which case a default name is auto-generated.
  - `log_analytics_sku`         - (optional|string) Azure Log Analytics Workspace mode SKU.
    The default value is set to "PerGB2018". For more information refer to [Microsoft's documentation](https://learn.microsoft.com/en-us/azure/azure-monitor//usage-estimated-costs#moving-to-the-new-pricing-model)

  NOTICE. Azure support for classic Application Insights mode will end on Feb 29th 2024.
  It's already not available in some of the new regions.

  NOTICE. Since upgrade to provider 3.x when destroying infrastructure with a classic
  Application Insights a resource is being left behind:
  `microsoft.alertsmanagement/smartdetectoralertrules`. This resource is not present in
  the state and it prevents resource group deletion.

  A workaround is to set the following provider configuration:

  ```
  provider "azurerm" {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
  }

  Example:

  ```
    {
        name                      = "AppInsights"
        workspace_mode            = true
        metrics_retention_in_days = 30
        log_analytics_name        = "LogAnalyticsName"
        log_analytics_sku         = "PerGB2018"
    }
  ```
  EOF
  default     = null
  type        = map(any)
}

variable "avset_id" {
  description = "The identifier of the Availability Set to use. When using this variable, set `avzone = null`."
  default     = null
  type        = string
}

variable "bootstrap_options" {
  description = <<-EOF
  Bootstrap options to pass to VM-Series instance.

  Proper syntax is a string of semicolon separated properties.
  Example:
    bootstrap_options = "type=dhcp-client;panorama-server=1.2.3.4"

  A list of available properties: storage-account, access-key, file-share,
  share-directory, type, ip-address, default-gateway, netmask, ipv6-address,
  ipv6-default-gateway, hostname, panorama-server, panorama-server-2, tplname, dgname,
  dns-primary, dns-secondary, vm-auth-key, op-command-modes, op-cmd-dpdk-pkt-io,
  plugin-op-commands, dhcp-send-hostname, dhcp-send-client-id, dhcp-accept-server-hostname,
  dhcp-accept-server-domain, auth-key, vm-series-auto-registration-pin-value,
  vm-series-auto-registration-pin-id.

  For more details on bootstrapping see documentation:
  https://docs.paloaltonetworks.com/vm-series/10-2/vm-series-deployment/bootstrap-the-vm-series-firewall/create-the-init-cfgtxt-file/init-cfgtxt-file-components
  EOF
  default     = ""
  type        = string
  sensitive   = true
}

variable "diagnostics_storage_uri" {
  description = "The storage account's blob endpoint to hold diagnostic files."
  default     = null
  type        = string
}

variable "enable_zones" {
  description = <<-EOF
  If false, the input `avzone` is ignored and also all created Public IP addresses default
  to not to use Availability Zones (the `No-Zone` setting). It is intended for the regions
  that do not yet support Availability Zones.
  EOF
  default     = true
  type        = bool
}

variable "identity_type" {
  description = "See the [provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#identity_type)."
  default     = "SystemAssigned"
  type        = string
}

variable "identity_ids" {
  description = "See the [provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#identity_ids)."
  default     = null
  type        = list(string)
}

variable "img_offer" {
  description = "The Azure Offer identifier corresponding to a published image. For `img_version` 9.1.1 or above, use \"vmseries-flex\"; for 9.1.0 or below use \"vmseries1\"."
  default     = "vmseries-flex"
  type        = string
}

variable "img_publisher" {
  description = "The Azure Publisher identifier for the image which will be deployed"
  default     = "paloaltonetworks"
  type        = string
}

variable "img_sku" {
  description = "VM-series SKU - list available with `az vm image list -o table --all --publisher paloaltonetworks`"
  default     = "byol"
  type        = string
}

variable "img_version" {
  description = <<-EOF
  The VM-series PAN-OS version. You can list what's available for a default `img_offer`
  with  the command:
  `az vm image list -o table --publisher paloaltonetworks --offer vmseries-flex --all`
  EOF
  default     = "10.1.0"
  type        = string
}

variable "interfaces" {
  description = <<-EOF
  An ordered list of the network interfaces.

  NOTE: The ORDER in which you specify the interfaces DOES MATTER.
  Interfaces will be attached to VM in the order you define here, therefore:
  * The first should be the management interface, which does not participate in data filtering
  * The remaining ones are the dataplane interfaces

  Options for an interface object:
  - `create_public_ip`     - (optional|bool) If true, create a public IP for the interface.
    Default is false
  - `enable_ip_forwarding` - (optional|bool) If true, the network interface will not
    discard packets sent to an IP address other than the one assigned. If false, the network interface only accepts traffic destined to its IP address
  - `name`                 - (required|string) Interface name
  - `private_ip_address`   - (optional|string) Static private IP to asssign to the interface.
    If null, dynamic one is allocated
  - `subnet_name`          - (required|string) Name of an existing subnet to create
    interface in. It must reside in the resource group
  - `vnet_name`            - (required|string) Name of an existing VNet that the subnet is in
  EOF
  type = list(object({
    create_public_ip     = optional(bool, false)
    enable_ip_forwarding = optional(bool, true)
    name                 = string
    private_ip_address   = optional(string)
    subnet_name          = string
    vnet_name            = string
  }))

  validation {
    condition = (
      strcontains(var.interfaces[0].name, "management")
      ||
      strcontains(var.interfaces[0].name, "mgmt")
    )
    error_message = "The management interface must be at index 0"
  }
}

variable "location" {
  description = "Region where to deploy VM-Series and dependencies."
  type        = string
}

variable "managed_disk_type" {
  description = <<-EOF
  The type of OS Managed Disk to create for the virtual machine. Possible values are
  `Standard_LRS`, `StandardSSD_LRS` or `Premium_LRS`. The `Premium_LRS` works only for
  selected `vm_size` values, details in Azure docs.
  EOF
  default     = "StandardSSD_LRS"
  type        = string
}

variable "name" {
  description = "VM-Series instance name."
  type        = string
}

variable "os_disk_name" {
  description = "Optional name of the OS disk to create for the virtual machine. If empty, the name is auto-generated."
  default     = null
  type        = string
}

variable "password" {
  description = <<-EOF
  Initial administrative password to use for VM-Series. If not defined the `ssh_key`
  variable must be specified. Mind the [Azure-imposed restrictions](
    https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-password-requirements-when-creating-a-vm
  ).
  EOF
  default     = null
  type        = string
  sensitive   = true
}

variable "public_ip_zones" {
  description = <<-EOF
  A collection containing the availability zone to allocate the Public IP in. Changing
  this forces a new resource to be created. Availability Zones are only supported with a
  Standard SKU and in select regions at this time. Standard SKU Public IP Addresses that
  do not specify a zone are not zone-redundant by default.
  EOF
  default     = null
  type        = list(number)
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
  description = "Name of the existing resource group where to place the resources created."
  type        = string
}

variable "ssh_keys" {
  description = <<-EOF
  A list of initial administrative SSH public keys that allow key-pair authentication.

  This is a list of strings, so each item should be the actual public key value. If you
  would like to load them from files instead, following method is available:

  ```
  [
    file("/path/to/public/keys/key_1.pub"),
    file("/path/to/public/keys/key_2.pub")
  ]
  ```

  If the `password` variable is also set, VM-Series will accept both authentication methods.
  EOF
  default     = []
  type        = list(string)
}

variable "subscription_id" {
  description = "The ID for the Azure subscription where the VMs will be deployed"
  type        = string
}

variable "username" {
  description = <<-EOF
  The initial administrator username to use for VM-Series. Mind the
  [Azure-imposed restrictions](
    https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm
  )
  EOF
  type        = string
}

variable "vm_size" {
  description = <<-EOF
  The Azure VM size (type) to be created. Consult the "VM-Series Deployment Guide", as
  only a few selected sizes are supported
  EOF
  default     = "Standard_D3_v2"
  type        = string
}

variable "vm_zone" {
  description = <<-EOF
  A single availability zone which the virtual machine should be allocated in. Changing
  this forces a new resource to be created. Ignored if `enable_zones` is false.
  Conflicts with `avset_id`, in which case use `avzone = null`."
  EOF
  default     = null
  type        = number
}
