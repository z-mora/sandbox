module "azure_app_registration" {
  for_each = var.app_registrations
  source   = "./modules/azure_app_registration"

  api_permissions = each.value.api_permissions
  certificates    = each.value.certificates
  display_name    = each.key
  secrets         = each.value.secrets
  web             = each.value.web
}

module "azure_availability_set" {
  for_each = var.availability_sets
  source   = "./modules/azure_availability_set"

  avset_name                      = each.key
  location                        = each.value.location
  managed                         = each.value.managed
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  platform_fault_domain_count     = each.value.platform_fault_domain_count
  platform_update_domain_count    = each.value.platform_update_domain_count
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )

  depends_on = [module.azure_resource_provider_registration["Microsoft.Compute"]]
}

module "azure_centralized_private_endpoint" {
  for_each  = var.centralized_private_endpoints
  providers = { azurerm = azurerm.corp_network }
  source    = "./modules/azure_centralized_private_endpoint"

  location          = each.value.location
  name              = each.key
  required_tags     = merge(var.default_tags, each.value.tags)
  resource_id       = each.value.resource_id
  subresource_names = each.value.subresource_names

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_consumption_budget" {
  for_each = var.consumption_budgets
  source   = "./modules/azure_consumption_budget"

  amount                  = each.value.amount
  consumption_budget_name = each.key
  end_date                = each.value.end_date
  management_group_name   = each.value.management_group_name
  notifications           = each.value.notifications
  dimensions              = each.value.dimensions
  resource_group_name     = each.value.resource_group_name
  start_date              = each.value.start_date
  tags                    = each.value.tags
  time_grain              = each.value.time_grain
  type                    = each.value.type
}

module "azure_data_factory" {
  for_each = var.data_factories
  source   = "./modules/azure_data_factory"

  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  name                            = each.key
  public_network_enabled          = each.value.public_network_enabled
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )

  depends_on = [module.azure_resource_provider_registration["Microsoft.DataFactory"]]
}

module "azure_dns_hub_custom_forwarding_ruleset" {
  for_each  = var.dns_hub_custom_forwarding_rulesets
  providers = { azurerm = azurerm.dns_hub }
  source    = "./modules/azure_dns_hub_custom_forwarding_ruleset"

  location            = each.value.location
  name                = each.key
  resource_group_name = each.value.resource_group_name
  required_tags       = merge(var.default_tags, each.value.tags)
  rules               = each.value.rules
  vnets               = { for key in each.value.vnet_keys : key => module.azure_virtual_network[key].id }

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_dns_hub_forwarding_ruleset" {
  for_each = var.dns_hub_forwarding_rulesets
  source   = "./modules/azure_dns_hub_forwarding_ruleset"

  custom_rules            = each.value.custom_rules
  inbound_endpoint_ip     = module.azure_private_dns_resolver[each.value.private_resolver_key].inbound_endpoint_ip
  location                = each.value.location
  name                    = each.key
  outbound_endpoint_id    = module.azure_private_dns_resolver[each.value.private_resolver_key].outbound_endpoint_id
  private_link_zone_names = module.azure_dns_hub_private_link_dns_zones[0].zone_names
  required_tags           = merge(var.default_tags, each.value.tags)
  resource_group_name     = each.value.resource_group_name

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_dns_hub_private_link_dns_zones" {
  count  = var.dns_hub_private_link_dns_zones == null ? 0 : 1
  source = "./modules/azure_dns_hub_private_link_dns_zones"

  is_gov              = local.is_gov
  required_tags       = merge(var.default_tags, var.dns_hub_private_link_dns_zones.tags)
  resource_group_name = var.dns_hub_private_link_dns_zones.resource_group_name
  vnet_ids = {
    for vnet_key in var.dns_hub_private_link_dns_zones.vnet_keys :
    vnet_key => module.azure_virtual_network[vnet_key].id
  }

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_eventhub_namespace" {
  for_each = var.eventhub_namespaces
  source   = "./modules/azure_eventhub_namespace"

  auto_inflate_enabled          = each.value.auto_inflate_enabled
  capacity                      = each.value.capacity
  eventhub_namespace_name       = each.key
  eventhubs                     = each.value.eventhubs
  location                      = each.value.location
  maximum_throughput_units      = each.value.maximum_throughput_units
  public_network_access_enabled = each.value.public_network_access_enabled
  required_tags                 = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  sku = each.value.sku

  depends_on = [module.azure_resource_provider_registration["Microsoft.EventHub"]]
}

module "azure_key_vault" {
  for_each = var.key_vaults
  source   = "./modules/azure_key_vault"

  enable_rbac_authorization       = each.value.enable_rbac_authorization
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  key_vault_name                  = each.key
  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  private_endpoints               = each.value.private_endpoints
  public_network_access_enabled   = each.value.public_network_access_enabled
  purge_protection_enabled        = each.value.purge_protection_enabled
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  sku                        = each.value.sku
  soft_delete_retention_days = each.value.soft_delete_retention_days

  depends_on = [module.azure_resource_provider_registration["Microsoft.KeyVault"]]
}

module "azure_load_balancer" {
  for_each = var.load_balancers
  source   = "./modules/azure_load_balancer"

  backend_pool_addresses          = each.value.backend_pool_addresses
  backend_pool_name               = each.value.backend_pool_name
  frontend_name                   = each.value.frontend_name
  frontend_subnet                 = each.value.frontend_subnet
  internal_or_external            = each.value.internal_or_external
  load_balancer_name              = each.key
  load_balancer_rules             = each.value.load_balancer_rules
  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  public_ip_name                  = each.value.public_ip_name
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  sku                  = each.value.sku
  subscription_id      = var.subscription_id
  virtual_network_name = each.value.virtual_network_name
  zones                = each.value.zones

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}


module "azure_log_analytics_workspace" {
  for_each = var.log_analytics_workspaces
  source   = "./modules/azure_log_analytics_workspace"

  daily_quota_gb             = each.value.daily_quota_gb
  internet_ingestion_enabled = each.value.internet_ingestion_enabled
  internet_query_enabled     = each.value.internet_query_enabled
  location                   = each.value.location
  name                       = each.key
  required_tags              = merge(var.default_tags, each.value.tags)
  resource_group_name        = each.value.resource_group_name
  retention_in_days          = each.value.retention_in_days
  sku                        = each.value.sku
}

module "azure_managed_identity" {
  for_each = var.managed_identities
  source   = "./modules/azure_managed_identity"

  location            = each.value.location
  name                = each.key
  required_tags       = merge(var.default_tags, each.value.tags)
  resource_group_name = each.value.resource_group_name

  depends_on = [module.azure_resource_provider_registration["Microsoft.ManagedIdentity"]]
}

module "azure_management_group_association" {
  count  = var.management_group_name != null ? 1 : 0
  source = "./modules/azure_management_group_association"

  management_group_name = var.management_group_name
  subscription_id       = var.subscription_id
}

module "azure_management_group" {
  source   = "./modules/azure_management_group"
  for_each = var.management_groups

  child_groups = each.value
  name         = each.key

  depends_on = [module.azure_resource_provider_registration["Microsoft.Management"]]
}

module "azure_monitor_diagnostic_setting" {
  for_each = var.monitor_diagnostic_settings
  source   = "./modules/azure_monitor_diagnostic_setting"

  activitylogs_eventhubs     = each.value.activitylogs_eventhubs
  activitylogs_log_analytics = each.value.activitylogs_log_analytics
  subscription_id            = var.subscription_id
}

module "azure_network_security_group" {
  for_each = var.network_security_groups
  source   = "./modules/azure_network_security_group"

  flowlogs_enable                 = each.value.flowlogs_enable
  flowlogs_resource_group_name    = each.value.flowlogs_resource_group_name
  flowlogs_retention_days         = each.value.flowlogs_retention_days
  flowlogs_storageaccount_id      = each.value.flowlogs_storageaccount_id
  flowlogs_subscription_id        = each.value.flowlogs_subscription_id
  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  name                            = each.key
  network_watcher_name            = try(module.azure_network_watcher[0].name_by_location[each.value.location], "NetworkWatcher_${each.value.location}")
  network_watcher_resource_group  = try(module.azure_network_watcher[0].resource_group_name, "NetworkWatcherRG")
  rules                           = each.value.rules
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_network_watcher" {
  count  = var.deploy_network_watcher ? 1 : 0
  source = "./modules/azure_network_watcher"

  is_gov = local.is_gov

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_palo_alto" {
  for_each = var.palo_altos
  source   = "./modules/azure_palo_alto"

  app_insights_settings = each.value.app_insights_settings
  avset_id = (
    each.value.avset_key == null ? null :
    module.azure_availability_set[each.value.avset_key].availability_set_id
  )
  img_version     = each.value.img_version
  interfaces      = each.value.interfaces
  location        = each.value.location
  name            = each.key
  os_disk_name    = "disk-${each.key}"
  password        = each.value.password
  public_ip_zones = each.value.public_ip_zones
  required_tags   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  subscription_id = var.subscription_id
  username        = each.value.username
  vm_size         = each.value.vm_size
  vm_zone         = each.value.vm_zone

  depends_on = [
    module.azure_resource_provider_registration["Microsoft.Compute"],
    module.azure_resource_provider_registration["Microsoft.Network"]
  ]
}

module "azure_policy" {
  for_each = var.policy_assignments
  source   = "./modules/azure_policy"

  built_in_assignments = each.value.built_in_assignments
  built_in_exemptions  = each.value.built_in_exemptions
  role_definition_name = each.value.role_definition_name

  depends_on = [
    module.azure_resource_provider_registration["Microsoft.GuestConfiguration"],
    module.azure_resource_provider_registration["Microsoft.PolicyInsights"]
  ]
}

module "azure_policy_custom" {
  for_each = var.custom_policies
  source   = "./modules/azure_policy_custom"

  initiative_definition_name = each.value.initiative_definition_name
  policy_assignments         = each.value.policy_assignments
  policy_exemptions          = each.value.policy_exemptions

  depends_on = [
    module.azure_resource_provider_registration["Microsoft.GuestConfiguration"],
    module.azure_resource_provider_registration["Microsoft.PolicyInsights"]
  ]
}

module "azure_policy_custom_definition" {
  for_each = var.custom_policy_definitions
  source   = "./modules/azure_policy_custom_definition"

  name                = each.key
  mode                = each.value.mode
  description         = each.value.description
  display_name        = each.value.display_name
  policy_rule         = each.value.policy_rule
  management_group_id = each.value.management_group_id
  metadata            = each.value.metadata
  parameters          = each.value.parameters
}

module "azure_policy_initiative" {
  for_each = var.policy_initiatives
  source   = "./modules/azure_policy_initiative"

  assignments = {
    for k, v in each.value.assignments : k => merge(v, (v.identity == null ? {} : {
      identity = {
        identity_ids = [
          for key in v.identity.managed_identity_keys :
          module.azure_managed_identity[key].id
        ]
        type = v.identity.type
      }
    }))
  }
  description                   = each.value.description
  display_name                  = each.value.display_name
  management_group_display_name = each.value.management_group_display_name
  metadata                      = each.value.metadata
  name                          = each.key
  parameters                    = each.value.parameters
  policy_definition_groups      = each.value.policy_definition_groups
  policy_definition_references  = each.value.policy_definition_references
}

module "azure_private_dns_resolver" {
  for_each = var.private_dns_resolvers
  source   = "./modules/azure_private_dns_resolver"

  inbound_subnet_id   = module.azure_virtual_network[each.value.vnet_key].private_subnets[each.value.inbound_subnet_key].id
  location            = each.value.location
  name                = each.key
  outbound_subnet_id  = module.azure_virtual_network[each.value.vnet_key].private_subnets[each.value.outbound_subnet_key].id
  required_tags       = merge(var.default_tags, each.value.tags)
  resource_group_name = each.value.resource_group_name
  virtual_network_id  = module.azure_virtual_network[each.value.vnet_key].id

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_recovery_services_vault" {
  for_each = var.recovery_services_vaults
  source   = "./modules/azure_recovery_services_vault"

  backup_policies               = each.value.backup_policies
  backup_policies_workloads     = each.value.backup_policies_workloads
  location                      = each.value.location
  name                          = each.key
  public_network_access_enabled = each.value.public_network_access_enabled
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  sku                 = each.value.sku
  soft_delete_enabled = each.value.soft_delete_enabled
  required_tags       = merge(var.default_tags, each.value.tags)

  depends_on = [module.azure_resource_provider_registration["Microsoft.RecoveryServices"]]
}

module "azure_resource_group" {
  for_each = var.resource_groups
  source   = "./modules/azure_resource_group"

  location            = each.value
  required_tags       = var.default_tags
  resource_group_name = each.key
}

module "azure_resource_provider_registration" {
  for_each = local.resource_providers_to_register
  source   = "./modules/azure_resource_provider_registration"

  name            = each.value
  platform        = var.platform
  subscription_id = var.subscription_id
}

module "azure_role" {
  for_each = var.azure_roles
  source   = "./modules/azure_role"

  actions          = each.value.actions
  data_actions     = each.value.data_actions
  not_actions      = each.value.not_actions
  not_data_actions = each.value.not_data_actions
  role_description = each.value.role_description
  role_name        = each.key
  scope            = each.value.scope == null ? "/subscriptions/${var.subscription_id}" : each.value.scope
}

module "azure_role_assignment" {
  for_each = var.role_assignments
  source   = "./modules/azure_role_assignment"

  group_display_names = each.value.group_display_names
  managed_identity_ids = {
    for key in each.value.managed_identity_keys :
    key => module.azure_managed_identity[key].principal_id
  }
  role = {
    id   = try(module.azure_role[each.value.role_name].id, null)
    name = each.value.role_name
  }
  scope = each.value.scope
  service_principal_ids = {
    for key in each.value.app_registration_keys :
    key => module.azure_app_registration[key].service_principal_id
  }
  user_principal_names = each.value.user_principal_names
}

module "azure_route_table" {
  for_each = merge(local.dmz_vnet_route_tables, var.route_tables)
  providers = {
    azurerm              = azurerm
    azurerm.corp_network = azurerm.corp_network
  }
  source = "./modules/azure_route_table"

  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  location                      = each.value.location
  required_tags                 = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  name   = each.key
  routes = each.value.routes

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_storage_account" {
  for_each = var.storage_accounts
  source   = "./modules/azure_storage_account"

  access_tier                     = each.value.access_tier
  account_kind                    = each.value.account_kind
  account_replication_type        = each.value.account_replication_type
  account_tier                    = each.value.account_tier
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  containers                      = each.value.containers
  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  name                            = each.key
  network_rules                   = each.value.network_rules
  private_endpoints               = each.value.private_endpoints
  public_network_access_enabled   = each.value.public_network_access_enabled
  required_tags                   = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )

  depends_on = [
    module.azure_resource_provider_registration["Microsoft.Network"],
    module.azure_resource_provider_registration["Microsoft.Storage"],
  ]
}

module "azure_virtual_network" {
  for_each = var.virtual_networks
  providers = {
    azurerm              = azurerm
    azurerm.corp_network = azurerm.corp_network
    azurerm.dns_hub      = azurerm.dns_hub
  }
  source = "./modules/azure_virtual_network"

  is_gov                          = local.is_gov
  cidr                            = each.value.cidr
  dns_servers                     = each.value.dns_servers
  gateway_subnet_address_prefix   = each.value.gateway_subnet_address_prefix
  is_dmz                          = each.value.is_dmz
  link_dns_hub_forwarding_ruleset = each.value.link_dns_hub_forwarding_ruleset
  location                        = each.value.location
  monitor_diagnostic_destinations = var.monitor_diagnostic_destinations
  name                            = each.key
  private_subnets = {
    for k, v in each.value.private_subnets : k => merge(v, {
      network_security_group_id = module.azure_network_security_group[v.network_security_group_key].id
      route_table_id = k == "AzureBastionSubnet" ? null : (
        v.route_table_key != null ? module.azure_route_table[v.route_table_key].id : (
          each.value.is_dmz == true && each.value.auto_create_dmz_route_table ? (
            strcontains(k, "appgw") ?
            module.azure_route_table[replace(each.key, "vnet-", "rt-appgw-")].id :
            module.azure_route_table[replace(each.key, "vnet-", "rt-")].id
          ) : null
        )
      )
      route_table_key = k == "AzureBastionSubnet" ? null : (
        v.route_table_key != null ? v.route_table_key : (
          each.value.is_dmz == true && each.value.auto_create_dmz_route_table ? (
            strcontains(k, "appgw") ?
            replace(each.key, "vnet-", "rt-appgw-") : replace(each.key, "vnet-", "rt-")
          ) : null
        )
      )
    })
  }
  required_tags = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )

  depends_on = [
    module.azure_resource_provider_registration["Microsoft.Insights"],
    module.azure_resource_provider_registration["Microsoft.Network"]
  ]
}

module "azure_virtual_wan" {
  for_each = var.virtual_wans
  source   = "./modules/azure_virtual_wan"

  allow_branch_to_branch_traffic = each.value.allow_branch_to_branch_traffic
  location                       = each.value.location
  required_tags                  = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  subscription_id  = var.subscription_id
  type             = each.value.type
  virtual_hubs     = each.value.virtual_hubs
  virtual_wan_name = each.key
  vpn_sites        = each.value.vpn_sites

  depends_on = [module.azure_resource_provider_registration["Microsoft.Network"]]
}

module "azure_windows_virtual_machine" {
  for_each = var.windows_virtual_machines
  source   = "./modules/azure_windows_virtual_machine"

  # TODO: At the moment we can only deploy VMs if the subnet is in the same state
  backup = each.value.backup == null ? null : {
    policy_id           = module.azure_recovery_services_vault[each.value.backup.rsv_key].backup_policies[each.value.backup.policy_key].id
    recovery_vault_name = module.azure_recovery_services_vault[each.value.backup.rsv_key].name
  }
  disk_size_gb             = each.value.disk_size_gb
  domain_join              = each.value.domain_join
  domain_join_build_script = var.windows_vm_build_script
  key_vault_id             = module.azure_key_vault[each.value.key_vault_key].id
  location                 = each.value.location
  managed_disks            = each.value.managed_disks
  network_interfaces       = each.value.network_interfaces
  private_subnets          = module.azure_virtual_network[each.value.virtual_network].private_subnets
  required_tags            = merge(var.default_tags, each.value.tags)
  resource_group_name = try(
    module.azure_resource_group[each.value.resource_group_name].name,
    each.value.resource_group_name
  )
  size                 = each.value.size
  sku                  = each.value.sku
  storage_account_type = each.value.storage_account_type
  timezone             = each.value.timezone
  virtual_machine_name = each.key
  zone                 = each.value.zone

  depends_on = [module.azure_resource_provider_registration["Microsoft.Compute"]]
}
