output "app_registrations" {
  description = "A collection of app registration and their non-sensitive outputs"
  value = length(module.azure_app_registration) > 0 ? {
    for app_key, app in module.azure_app_registration : app_key => {
      for k, v in app : k => v if k != "client_secrets"
    }
  } : null
}

output "app_registration_secrets" {
  description = "A collection of app registrations & their client secrets"
  sensitive   = true
  value = length(
    flatten([for a in module.azure_app_registration : [for s in a.client_secrets : s]])
    ) > 0 ? {
    for app_key, app in module.azure_app_registration :
    app_key => app.client_secrets if length(app.client_secrets) > 0
  } : null
}

output "data_factories" {
  description = "A map of the data factories that were deployed & their outputs"
  value       = length(module.azure_data_factory) > 0 ? module.azure_data_factory : null
}

output "dns_hub_forwarding_rulesets" {
  description = <<-EOL
  A map of the DNS hub's centralized forwarding rulesets by region and their outputs.
  These should be used by all DMZ VNets for centralized DNS.
  EOL
  value = length(module.azure_dns_hub_forwarding_ruleset) == 0 ? null : {
    for k, v in module.azure_dns_hub_forwarding_ruleset : v.location => merge(v, {
      name            = k
      subscription_id = var.subscription_id
    })
  }
}

output "dns_hub_private_link_dns_zones" {
  description = "The outputs of the module azure_dns_hub_private_link_dns_zones"
  value       = try(module.azure_dns_hub_private_link_dns_zones[0], null)
}

output "initial_windows_vm_admin_passwords" {
  description = <<EOL
  The initial admin password for each Windows VM. The password Will be changed by
  BeyondTrust immediately upon AD join. The value of this output is a map where the
  key is the VM name and the value is the password.
  EOL
  sensitive   = true
  value = length(module.azure_windows_virtual_machine) > 0 ? {
    for k, v in module.azure_windows_virtual_machine : k => v.initial_admin_password
  } : null
}

output "managed_identities" {
  description = "A map of the user-assigned managed identities that were created & their outputs"
  value       = length(module.azure_managed_identity) == 0 ? null : module.azure_managed_identity
}

output "monitor_diagnostic_destinations" {
  description = <<-EOL
  Central logging destinations that are used by other Terragrunt modules to configure
  monitor diagnostic settings. The log analytics workspace doesn't have to be in the
  same region as the resource being logged. The eventhub namespace does need to be in
  the same region as the resource being logged.
  EOL
  # This could use some more work in the future
  # It assumes there's only 1 log analytics workspace and references the first one found
  # It assumes all of these logging resources share a resource group
  # It assume the eventhub namespace only has 1 eventhub and references the first one
  value = length(var.log_analytics_workspaces) > 0 && length(var.eventhub_namespaces) > 0 ? {
    eventhubs = { for k, v in module.azure_eventhub_namespace : v.location => {
      authorization_rule_id = "/subscriptions/${var.subscription_id}/resourceGroups/${one(keys(var.resource_groups))}/providers/Microsoft.EventHub/namespaces/${v.name}/authorizationRules/RootManageSharedAccessKey"
      eventhub_name         = v.first_eventhub_name
      namespace_name        = v.name
    } }
    log_analytics_workspace_id = module.azure_log_analytics_workspace[one(keys(module.azure_log_analytics_workspace))].id
    resource_group_name        = one(keys(var.resource_groups))
    subscription_id            = var.subscription_id
  } : null
}

output "palo_altos" {
  description = "A map of the Palo Altos that were deployed"
  value       = length(module.azure_palo_alto) == 0 ? null : module.azure_palo_alto
}

output "storage_accounts" {
  description = "A map of the storage accounts that were deployed & their outputs"
  value       = length(module.azure_storage_account) > 0 ? module.azure_storage_account : null
}

output "windows_vms" {
  description = "A map of Windows VMs and their non-sensitive outputs"
  value = length(module.azure_windows_virtual_machine) > 0 ? {
    for key, vm in module.azure_windows_virtual_machine : key => {
      for k, v in vm : k => v if k != "initial_admin_password"
    }
  } : null
}
