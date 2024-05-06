variable "app_registrations" {
  type = map(object({
    api_permissions = optional(map(list(string)), {})
    certificates = optional(map(object({
      encoding          = optional(string, "pem")
      end_date          = optional(string)
      end_date_relative = optional(string)
      type              = string
      value             = string
    })), {})
    secrets = optional(map(object({
      auto_rotate_days  = optional(number)
      end_date_relative = optional(string)
      staggered_rotation = optional(object({
        overlap_days = optional(number, 10)
        rotate_days  = number
      }))
      vault = optional(object({
        mount = string
        path  = string
      }))
    })), {})
    web = optional(object({
      homepage_url = optional(string)
      implicit_grant = optional(object({
        access_token_issuance_enabled = optional(bool, false)
        id_token_issuance_enabled     = optional(bool, false)
      }))
      logout_url    = optional(string)
      redirect_uris = optional(list(string))
    }))
  }))
  default     = {}
  description = "A collection of app registrations to create in Azure AD"
}

variable "availability_sets" {
  type = map(object({
    location                     = string
    managed                      = optional(bool)
    platform_fault_domain_count  = optional(string)
    platform_update_domain_count = optional(string)
    resource_group_name          = string
    tags                         = optional(map(string))
  }))
  description = "Object map of Azure Availability Sets"
  default     = {}
}

# TODO - this should be renamed to just "roles"
variable "azure_roles" {
  type = map(object({
    actions          = list(string)
    data_actions     = list(string)
    not_actions      = list(string)
    not_data_actions = list(string)
    role_description = string
    scope            = optional(string)
  }))
  description = <<-EOL
  A map of custom roles to be created. If `scope` is left blank, it's set to the current
  subscription.
  EOL
  default     = {}
}

variable "centralized_private_endpoints" {
  default     = {}
  description = <<-DESCRIPTION
  A collection of private endpoints to create in the corporate network subscription.
  This should only be used for internal, corporate resources that don't have a VNet in
  their subscription.
  DESCRIPTION
  type = map(object({
    location          = string
    resource_id       = string
    subresource_names = list(string)
    tags              = optional(map(string))
  }))
}

variable "consumption_budgets" {
  type = map(object({
    amount = number
    dimensions = optional(map(object({
      name     = string
      operator = optional(string)
      values   = list(string)
    })))
    end_date              = optional(string)
    management_group_name = optional(string)
    notifications = map(object({
      contact_emails = optional(list(string))
      contact_groups = optional(list(string))
      contact_roles  = optional(list(string))
      enabled        = optional(bool)
      operator       = string
      threshold      = number
      threshold_type = optional(string)
    }))
    resource_group_name = optional(string)
    start_date          = string
    tags = optional(map(object({
      name     = string
      operator = optional(string)
      values   = list(string)
    })))
    time_grain = optional(string)
    type       = string
  }))
  description = "map of consumption budget objects"
  default     = {}
}

variable "corp_dns_subscription_id" {
  type        = string
  description = "Subscription ID of the DNS hub"
}

variable "corp_network_subscription_id" {
  type        = string
  description = "Subscription Id of the Virtual Hub"
}

variable "custom_policies" {
  type = map(object({
    initiative_definition_name = string
    policy_assignments = map(object({
      enforce         = bool
      initiative_name = string
      scope           = string
      scope_id        = string
    }))
    policy_exemptions = optional(map(object({
      assignment_name = string
      category        = string
      scope           = string
      scope_id        = string
    })), {})
  }))
  description = "Map of nested values for Custom Policy/Initiative implementations"
  default     = {}
}

variable "custom_policy_definitions" {
  type = map(object({
    description         = string
    display_name        = string
    metadata            = optional(map(any))
    mode                = string
    management_group_id = optional(string)
    parameters = optional(map(object({
      type = string
      metadata = optional(object({
        description       = optional(string)
        displayName       = optional(string)
        strongType        = optional(string)
        assignPermissions = optional(bool)
      }))
      allowedValues = optional(list(string))
      defaultValue  = optional(string)
    })))
    policy_rule = string
  }))
  description = "Map defining a custom policy definition"
  default     = {}
}

variable "data_factories" {
  default     = {}
  description = "A collection of data factories to deploy"
  type = map(object({
    location               = string
    public_network_enabled = optional(bool, false)
    resource_group_name    = string
    tags                   = optional(map(string))
  }))
}

variable "default_tags" {
  type = object({
    App         = string
    Environment = string
    GBU         = string
    JobWbs      = string
    Notes       = optional(string)
    Owner       = string
  })
  description = "Required default tags which can be overriden"

  validation {
    condition     = contains(["DEV", "DR", "PROD", "QA", "TEST"], var.default_tags.Environment)
    error_message = "Environment tag must be one of: DEV, TEST, QA, PROD, DR"
  }

  validation {
    condition     = contains(["COR", "FED", "INF", "MEA"], var.default_tags.GBU)
    error_message = "GBU tag must be one of: COR, FED, INF, MEA"
  }

  validation {
    condition     = can(regex("^\\d{6}-\\d{5}$", var.default_tags.JobWbs))
    error_message = "JobWbs tag must be digits in the format xxxxxx-xxxxx"
  }

  validation {
    condition     = can(regex("(?i)[A-Z0-9+_.-]+@[A-Z0-9.-]+", var.default_tags.Owner))
    error_message = "Owner tag must be a valid email address"
  }
}

variable "deploy_network_watcher" {
  type        = bool
  description = <<-EOL
  If True, this will deploy a Network Watcher Resource Group and network watcher resources in the following regions:
  Commercial - eastus2 and westus2
  Government - usgovvirginia
  EOL
  default     = false
}

variable "dns_hub_custom_forwarding_rulesets" {
  default     = {}
  description = <<-EOL
  A collection of DNS forwarding rulesets to create in the DNS hub. This should only be
  used if a DMZ VNet needs to conditionally forward requests to their own internal DNS
  server. The key is the domain name (without a period at the end). Each target DNS
  server should be in the format "IP:port".
  EOL
  type = map(object({
    location            = string
    resource_group_name = optional(string, "rg-dns-prod-01")
    rules = map(object({
      enabled            = optional(bool, true)
      target_dns_servers = set(string)
    }))
    tags      = optional(map(string))
    vnet_keys = list(string)
  }))
}

variable "dns_hub_forwarding_rulesets" {
  default     = {}
  description = <<-EOL
  A collection of DNS hub forwarding rulesets to create. This should only be used to
  create centralized DNS hub rulesets that the DMZ VNets will all be linked to. The
  inbound endpoint IP and outbound endpoint ID will be grabbed from the outputs of the
  provided `private_resolver_key`. The private DNS zones will be pulled from the outputs
  of the `azure_dns_hub_private_link_dns_zones` module to be used for creating rules.
  `custom_rules` should only be used if you need to force resolution of a resource's
  public endpoint. The key is the domain name (without a period at the end). Each target
  DNS server should be in the format "IP:port".
  EOL
  type = map(object({
    custom_rules = optional(map(object({
      enabled            = optional(bool, true)
      target_dns_servers = set(string)
    })), {})
    location             = string
    private_resolver_key = string
    resource_group_name  = string
    tags                 = optional(map(string))
  }))
}

variable "dns_hub_private_link_dns_zones" {
  description = "Map value of Private DNS Zone info"
  type = object({
    resource_group_name = string
    tags                = optional(map(string))
    vnet_keys           = optional(list(string), [])
  })
  default = null
}

variable "environment" {
  type        = string
  default     = null
  description = "The cloud env which should be used. Used to set cloud to usgovernment"
}

variable "eventhub_namespaces" {
  type = map(object({
    auto_inflate_enabled = bool
    capacity             = number
    eventhubs = map(object({
      message_retention = number
      partition_count   = number
    }))
    location                      = string
    maximum_throughput_units      = number
    public_network_access_enabled = optional(bool, false)
    resource_group_name           = string
    sku                           = string
    tags                          = optional(map(string))
  }))
  description = "Map of objects for Eventhubs"
  default     = {}
}

variable "key_vaults" {
  type = map(object({
    enable_rbac_authorization       = optional(bool, true)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    location                        = string
    private_endpoints = optional(map(object({
      subnet = object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
      })
    })), {})
    public_network_access_enabled = optional(bool, false)
    purge_protection_enabled      = optional(bool)
    resource_group_name           = string
    sku                           = optional(string, "standard")
    soft_delete_retention_days    = optional(number, 90)
    tags                          = optional(map(string))
  }))
  description = "Map of objects for azure key vaults"
  default     = {}
}

variable "load_balancers" {
  type = map(object({
    backend_pool_addresses = map(object({
      backend_ip_address        = string
      backend_pool_address_name = string
    }))
    backend_pool_name    = string
    frontend_name        = string
    frontend_subnet      = string
    internal_or_external = string
    load_balancer_rules = map(object({
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
    location             = string
    public_ip_name       = string
    resource_group_name  = string
    sku                  = string
    tags                 = optional(map(string))
    virtual_network_name = string
    zones                = optional(list(string))
  }))
  description = "Map of nested values for load balancers"
  default     = {}
}

variable "log_analytics_workspaces" {
  type = map(object({
    daily_quota_gb             = optional(number, -1)
    internet_ingestion_enabled = optional(bool, true)
    internet_query_enabled     = optional(bool, true)
    location                   = string
    resource_group_name        = string
    retention_in_days          = number
    sku                        = string
    tags                       = optional(map(string))
  }))
  description = "Map of objects for Log Analytics Workspaces"
  default     = {}
}

variable "managed_identities" {
  default     = {}
  description = "A collection of user-assigned managed identities to create"
  type = map(object({
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
  }))
}

variable "management_group_name" {
  type        = string
  description = "management group name; used for management group subscription association"
  default     = null
}

variable "management_groups" {
  type        = map(any)
  description = "Map of management groups"
  default     = {}
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

  The only time this shouldn't be used is when running a Terragrunt module that manages
  the logging destinations.
  EOL
  default     = null
}

variable "monitor_diagnostic_settings" {
  type = map(object({
    activitylogs_eventhubs = map(object({
      eventhub_name                     = string
      eventhubspace_name                = string
      eventhubspace_resource_group_name = string
      eventhubspace_subscription_id     = string
    }))
    activitylogs_log_analytics = map(object({
      log_analytics_resource_group_name = string
      log_analytics_subscription_id     = string
      log_analytics_workspace_id        = string
    }))
  }))
  description = "Map of objects for Monitor Diagnostic Settings"
  default     = {}
}

variable "network_security_groups" {
  type = map(object({
    flowlogs_enable              = bool
    flowlogs_resource_group_name = string
    flowlogs_retention_days      = string
    flowlogs_storageaccount_id   = string
    flowlogs_subscription_id     = string
    location                     = string
    rules = map(object({
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
    resource_group_name = string
    tags                = optional(map(string))
  }))
  description = "Object map of network security rules"
  default     = {}
}

variable "palo_altos" {
  type = map(object({
    app_insights_settings = optional(map(any), {})
    avset_key             = optional(string)
    img_version           = string
    interfaces = list(object({
      create_public_ip     = optional(bool, false)
      enable_ip_forwarding = optional(bool, true)
      name                 = string
      private_ip_address   = optional(string)
      subnet_name          = string
      vnet_name            = string
    }))
    location            = string
    os_disk_name        = optional(string)
    password            = string
    public_ip_zones     = optional(list(number))
    resource_group_name = string
    tags                = optional(map(string))
    username            = string
    vm_size             = string
    vm_zone             = optional(number)
  }))
  description = "Collection of Palo Alto virtual machines"
  default     = {}
}

variable "platform" {
  type        = string
  description = <<-EOL
  The current OS, determined by Terragrunt. Some of the returned values can be:
  darwin, freebsd, linux, windows
  See: https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_platform
  EOL
}

variable "policy_assignments" {
  type = map(object({
    built_in_assignments = map(object({
      name                   = string
      description            = string
      enforce                = bool
      policy_definition_id   = string
      scope                  = string
      scope_id               = string
      parameters             = optional(string)
      metadata               = optional(string)
      location               = string
      identity_type          = string              # The type of identity to assign (e.g., 'UserAssigned' or 'SystemAssigned')
      identity_ids           = optional(list(any)) # List of identity IDs to assign (empty list for 'SystemAssigned')
      role_assignment_needed = bool
    }))
    built_in_exemptions = optional(map(object({
      assignment_name = string
      category        = string
      scope           = string
      scope_id        = string
    })), {})
    role_definition_name = optional(string)
  }))
  description = "Map of nested values for Built-In Policy implementations"
  default     = {}
}

variable "policy_initiatives" {
  default     = {}
  description = <<DESCRIPTION
  A collection of policy initiatives to create. At least one policy definition must be
  added to the initiative, which can be a custom or built-in policy definition. Only
  management_group and subscription assignments are supported.
  DESCRIPTION
  type = map(object({
    assignments = optional(map(object({
      description = optional(string)
      enforce     = optional(bool, true)
      identity = optional(object({
        managed_identity_keys = optional(list(string), [])
        type                  = string
      }))
      location   = optional(string, "eastus2")
      scope_type = string
      exemptions = optional(map(object({
        category     = string
        description  = optional(string)
        display_name = string
        scope_type   = string
      })), {})
    })), {})
    description                   = optional(string)
    display_name                  = string
    management_group_display_name = optional(string)
    metadata                      = optional(map(any))
    parameters                    = optional(map(any))
    policy_definition_groups = optional(map(object({
      category     = optional(string)
      description  = optional(string)
      display_name = optional(string)
    })), {})
    policy_definition_references = map(object({
      definition_display_name = optional(string)
      parameters = optional(map(object({
        list_value   = optional(list(string))
        string_value = optional(string)
      })), {})
      reference_id       = optional(string)
      policy_group_names = optional(list(string))
    }))
  }))
}

variable "private_dns_resolvers" {
  description = "A map of DNS resolver configurations."
  type = map(object({
    inbound_subnet_key  = string
    location            = string
    outbound_subnet_key = string
    resource_group_name = string
    tags                = optional(map(string))
    vnet_key            = string
  }))
  default = {}
}

variable "recovery_services_vaults" {
  type = map(object({
    backup_policies = optional(map(object({
      backup = object({
        frequency = string
        time      = string
      })
      resource_group_name = string
      retention_daily = object({
        count = number
      })
      retention_monthly = object({
        count    = number
        weekdays = list(string)
        weeks    = list(string)
      })
      retention_weekly = object({
        count    = number
        weekdays = list(string)
      })
      retention_yearly = object({
        count    = number
        months   = list(string)
        weekdays = list(string)
        weeks    = list(string)
      })
    })), {})
    backup_policies_workloads = optional(map(object({
      resource_group_name = string
      workload_type       = string
      settings = object({
        compression_enabled = bool
        time_zone           = string
      })
      protection_policies = map(object({
        backup = object({
          frequency = string
          time      = string
        })
        policy_type = string
        retention_daily = object({
          count = number
        })
      }))
    })), {})
    location                      = string
    public_network_access_enabled = optional(bool, false)
    resource_group_name           = string
    sku                           = string
    soft_delete_enabled           = bool
    tags                          = optional(map(string))
  }))
  description = "Recovery Services Vaults, each vault contains its own backup policies and backup policies workload"
  default     = {}
}

variable "resource_groups" {
  type        = map(string)
  description = "Resource groups to create. The key is the name and the value is the region"
  default     = {}
}

variable "role_assignments" {
  default     = {}
  description = "A collection of role assignments to deploy"
  type = map(object({
    app_registration_keys = optional(set(string), [])
    group_display_names   = optional(set(string), [])
    managed_identity_keys = optional(set(string), [])
    role_name             = string
    scope = object({
      display_name = optional(string)
      id           = optional(string)
      type         = optional(string)
    })
    user_principal_names = optional(set(string), [])
  }))
}

variable "route_tables" {
  type = map(object({
    disable_bgp_route_propagation = optional(bool, false)
    location                      = string
    resource_group_name           = string
    routes = map(object({
      address_prefix         = string
      next_hop_in_ip_address = optional(string)
      next_hop_type          = string
    }))
    tags = optional(map(string))
  }))
  description = "Map of nested values for custom route tables, routes and assignments to subnets"
  default     = {}
}

variable "storage_accounts" {
  type = map(object({
    access_tier                     = optional(string, "Hot")
    account_kind                    = optional(string, "StorageV2")
    account_replication_type        = string
    account_tier                    = string
    allow_nested_items_to_be_public = optional(bool, false)
    containers = optional(map(object({
      container_access_type = optional(string, "private")
    })), {})
    location = string
    network_rules = optional(object({
      bypass   = optional(set(string), ["AzureServices"])
      ip_rules = list(string)
    }))
    private_endpoints = optional(map(object({
      subnet = object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
      })
      subresource_name = string
    })), {})
    public_network_access_enabled = optional(bool, false)
    resource_group_name           = string
    tags                          = optional(map(string))
  }))
  description = "Map of objects for Storage Accounts"
  default     = {}
}

variable "subscription_id" {
  type        = string
  description = "ID for the Azure subscription"
  default     = null

  validation {
    condition     = var.subscription_id == lower(var.subscription_id)
    error_message = "The subscription ID should be in all lower case."
  }
}

variable "virtual_networks" {
  type = map(object({
    auto_create_dmz_route_table     = optional(bool, true)
    cidr                            = list(string)
    dns_servers                     = optional(list(string))
    is_dmz                          = optional(bool)
    gateway_subnet_address_prefix   = optional(list(string))
    link_dns_hub_forwarding_ruleset = optional(bool, false)
    location                        = string
    private_subnets = map(object({
      address_prefixes                              = list(string)
      delegation_actions                            = optional(list(string))
      delegation_name                               = optional(string)
      delegation_service                            = optional(string)
      network_security_group_key                    = string
      private_endpoint_network_policies_enabled     = optional(bool, false)
      private_link_service_network_policies_enabled = optional(bool, false)
      route_table_key                               = optional(string)
      service_endpoints                             = optional(list(string))
    }))
    resource_group_name = string
    tags                = optional(map(string))
  }))
  description = "Map of nested values for virtual networks and subnets"
  default     = {}
}

variable "virtual_wans" {
  type = map(object({
    allow_branch_to_branch_traffic = bool
    disable_vpn_encryption         = bool
    location                       = string
    resource_group_name            = string
    tags                           = optional(map(string))
    type                           = string
    virtual_hubs = map(object({
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
    vpn_sites = map(object({
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
  }))
  description = "Map of objects for virtual HUBs"
  default     = {}
}

variable "windows_virtual_machines" {
  type = map(object({
    backup = optional(object({
      policy_key = string
      rsv_key    = string
    }))
    disk_size_gb  = number
    domain_join   = bool
    key_vault_key = string
    location      = string
    managed_disks = map(object({
      create_option        = string
      disk_size_gb         = number
      lun                  = number
      storage_account_type = string
      tier                 = string
      zone                 = optional(number)
    }))
    network_interfaces = map(object({
      enable_accelerated_networking = bool
      enable_ip_forwarding          = bool
      private_ip_address_allocation = string
      subnet_key                    = string
    }))
    resource_group_name  = string
    size                 = string
    sku                  = string
    storage_account_type = string
    tags                 = optional(map(string))
    timezone             = string
    virtual_network      = string
    zone                 = optional(number)
  }))
  description = "Map of objects for Windows Virtual Machines"
  default     = {}
}

variable "windows_vm_build_script" {
  type        = string
  description = "Base64 byte string of the build script file"
  default     = null
}
