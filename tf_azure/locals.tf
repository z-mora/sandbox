locals {
  dmz_vnet_route_tables = merge({
    for k, v in var.virtual_networks : replace(k, "vnet-", "rt-") => {
      disable_bgp_route_propagation = false
      location                      = v.location
      resource_group_name           = v.resource_group_name
      routes = {
        "route-default-to-ilb" = {
          address_prefix         = "0.0.0.0/0"
          next_hop_in_ip_address = "TBD" # This will be looked up later in the RT module
          next_hop_type          = "VirtualAppliance"
        }
      }
      tags = null
    } if v.is_dmz == true && v.auto_create_dmz_route_table
    }, {
    for k, v in var.virtual_networks : replace(k, "vnet-", "rt-appgw-") => {
      disable_bgp_route_propagation = false
      location                      = v.location
      resource_group_name           = v.resource_group_name
      routes = {
        "route-10-to-ilb" = {
          address_prefix         = "10.0.0.0/8"
          next_hop_in_ip_address = "TBD" # This will be looked up later in the RT module
          next_hop_type          = "VirtualAppliance"
        }
        "route-172-to-ilb" = {
          address_prefix         = "172.16.0.0/12"
          next_hop_in_ip_address = "TBD" # This will be looked up later in the RT module
          next_hop_type          = "VirtualAppliance"
        }
        "route-default-to-internet-appgw" = {
          address_prefix         = "0.0.0.0/0"
          next_hop_in_ip_address = ""
          next_hop_type          = "Internet"
        }
      }
      tags = null
    } if local.vnet_has_appgw_subnet[k] && v.is_dmz == true && v.auto_create_dmz_route_table
  })
  is_gov = var.environment == "usgovernment"
  resource_providers_to_register = toset([for item in [
    length(var.availability_sets) > 0 ? "Microsoft.Compute" : null,
    length(var.centralized_private_endpoints) > 0 ? "Microsoft.Network" : null,
    length(var.data_factories) > 0 ? "Microsoft.DataFactory" : null,
    var.deploy_network_watcher ? "Microsoft.Network" : null,
    length(var.dns_hub_custom_forwarding_rulesets) > 0 ? "Microsoft.Network" : null,
    length(var.dns_hub_forwarding_rulesets) > 0 ? "Microsoft.Network" : null,
    # Microsoft.DBforPostgreSQL must be registered in the DNS subscription for a SQL
    # server's VNet integration to be configured w/ its DNS pointing to the central zone
    var.dns_hub_private_link_dns_zones != null ? "Microsoft.DBforPostgreSQL" : null,
    var.dns_hub_private_link_dns_zones != null ? "Microsoft.Network" : null,
    length(var.eventhub_namespaces) > 0 ? "Microsoft.EventHub" : null,
    length(var.key_vaults) > 0 ? "Microsoft.KeyVault" : null,
    length(var.load_balancers) > 0 ? "Microsoft.Network" : null,
    length(var.managed_identities) > 0 ? "Microsoft.ManagedIdentity" : null,
    length(var.management_groups) > 0 ? "Microsoft.Management" : null,
    length(var.network_security_groups) > 0 ? "Microsoft.Network" : null,
    length(var.palo_altos) > 0 ? "Microsoft.Compute" : null,
    length(var.palo_altos) > 0 ? "Microsoft.Network" : null,
    length(var.policy_assignments) > 0 ? "Microsoft.GuestConfiguration" : null,
    length(var.policy_assignments) > 0 ? "Microsoft.PolicyInsights" : null,
    length(var.private_dns_resolvers) > 0 ? "Microsoft.Network" : null,
    length(var.recovery_services_vaults) > 0 ? "Microsoft.RecoveryServices" : null,
    length(var.route_tables) > 0 ? "Microsoft.Network" : null,
    length(var.storage_accounts) > 0 ? "Microsoft.Network" : null,
    length(var.storage_accounts) > 0 ? "Microsoft.Storage" : null,
    length(var.virtual_networks) > 0 ? "Microsoft.Insights" : null,
    length(var.virtual_networks) > 0 ? "Microsoft.Network" : null,
    length(var.virtual_wans) > 0 ? "Microsoft.Network" : null,
    length(var.windows_virtual_machines) > 0 ? "Microsoft.Compute" : null,
  ] : item if item != null])
  vnet_has_appgw_subnet = {
    for vnet_key, vnet in var.virtual_networks : vnet_key => anytrue([
      for subnet_key, subnet in vnet.private_subnets : strcontains(subnet_key, "appgw")
    ])
  }
}
