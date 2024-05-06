# This is the Azure Terragrunt config used by every Azure Terragrunt module.
# For more info about Terragrunt see: https://confluence.parsons.com/x/xQFgCw

locals {
  branch = get_env("TERRAFORM_BRANCH", "main") # Get branch from Jenkins env var
  # TODO - Use strcontains() when Terraform v1.5 comes out
  is_gov        = length(regexall("gov", get_terragrunt_dir())) > 0 ? true : false
  is_jenkins    = try(get_env("USER") == "jenkins", false)
  local_source  = get_platform() == "windows" ? "C:/dev/code/cm/tf_azure" : "/code/cm/tf_azure"
  remote_source = "git::ssh://git@git.parsons.com:7999/cm/tf_azure.git//?ref=${local.branch}"
  remote_state_subscription = (
    local.is_gov ?
    "9ccec388-0679-4423-aa03-17442a44814d" : "c86901b0-1a88-4236-be6f-281a1dff9bf4"
  )
  remote_state_tenant = (
    local.is_gov ?
    "5d8b83ea-b573-4f09-a2a9-c904b7a56ece" : "8d088ff8-7e52-4d0f-8187-dcd9ca37815a"
  )
}

inputs = {
  is_jenkins              = local.is_jenkins
  platform                = get_platform()
  windows_vm_build_script = filebase64(find_in_parent_folders("windows_domain_join.ps1"))
}

remote_state {
  backend = "azurerm"
  config = {
    container_name       = "tfstate"
    environment          = local.is_gov ? "usgovernment" : "public"
    key                  = "azure/${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "rg-infraops-prod-01"
    storage_account_name = local.is_gov ? "stparsonstfstategov" : "stparsonstfstatecomm"
    subscription_id      = local.remote_state_subscription
    tenant_id            = local.remote_state_tenant
  }
}

terraform {
  source = local.is_jenkins ? local.remote_source : local.local_source

  extra_arguments "var_files" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      find_in_parent_folders("common.tfvars"),
    ]
    optional_var_files = [
      "${get_terragrunt_dir()}/azure_app_registration.tfvars",
      "${get_terragrunt_dir()}/azure_availability_set.tfvars",
      "${get_terragrunt_dir()}/azure_backup.tfvars", # TODO: Rename this to RSV
      "${get_terragrunt_dir()}/azure_centralized_private_endpoint.tfvars",
      "${get_terragrunt_dir()}/azure_consumption_budgets.tfvars",
      "${get_terragrunt_dir()}/azure_data_factory.tfvars",
      "${get_terragrunt_dir()}/azure_dns_hub_custom_forwarding_ruleset.tfvars",
      "${get_terragrunt_dir()}/azure_dns_hub_forwarding_ruleset.tfvars",
      "${get_terragrunt_dir()}/azure_dns_hub_private_link_dns_zones.tfvars",
      "${get_terragrunt_dir()}/azure_eventhub_namespaces.tfvars",
      "${get_terragrunt_dir()}/azure_key_vault.tfvars",
      "${get_terragrunt_dir()}/azure_load_balancer.tfvars",
      "${get_terragrunt_dir()}/azure_log_analytics.tfvars",
      "${get_terragrunt_dir()}/azure_managed_identity.tfvars",
      "${get_terragrunt_dir()}/azure_management_group.tfvars",
      "${get_terragrunt_dir()}/azure_monitor_diagnostic_settings.tfvars",
      "${get_terragrunt_dir()}/azure_network_security_group.tfvars",
      "${get_terragrunt_dir()}/azure_palo_alto.tfvars",
      "${get_terragrunt_dir()}/azure_policy_custom.tfvars",
      "${get_terragrunt_dir()}/azure_policy.tfvars",
      "${get_terragrunt_dir()}/azure_policy_initiative.tfvars",
      "${get_terragrunt_dir()}/azure_private_dns_resolver.tfvars",
      "${get_terragrunt_dir()}/azure_role.tfvars",
      "${get_terragrunt_dir()}/azure_role_assignment.tfvars",
      "${get_terragrunt_dir()}/azure_route_table.tfvars",
      "${get_terragrunt_dir()}/azure_storage_accounts.tfvars",
      "${get_terragrunt_dir()}/azure_virtual_network.tfvars",
      "${get_terragrunt_dir()}/azure_virtual_wan.tfvars",
      "${get_terragrunt_dir()}/azure_windows_virtual_machine.tfvars",
      (
        fileexists("${get_terragrunt_dir()}/default.tfvars") ?
        "${get_terragrunt_dir()}/default.tfvars" :
        find_in_parent_folders("default.tfvars")
      ),
    ]
  }
}

terraform_version_constraint  = ">= 1.5, < 1.6"
terragrunt_version_constraint = ">= 0.48"

retry_max_attempts       = 6
retry_sleep_interval_sec = 30

# Made regex case-insensitive to account for the case ever changing
retryable_errors = [
  # Error thrown when trying to create a VNet peering resource
  "(?is).*Error: waiting for Virtual Network Peering.*",
  # Error thrown if another deployment is already modifying something, like the VWAN hub route table
  "(?is).*AnotherOperationInProgress.*",
  "(?is).*Error acquiring the state lock.*",
  # Error thrown on new subscriptions when trying to assign the ALZ admin role
  # Should go away on the 2nd apply
  "(?is).*could not find role '.*'.*",
  # Random Azure error, unable to get hub's route table route
  "(?is).*Error: retrieving Hub Route Table Route.*",
]
