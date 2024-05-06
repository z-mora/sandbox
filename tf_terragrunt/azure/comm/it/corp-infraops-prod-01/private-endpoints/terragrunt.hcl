include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "resources" {
  config_path = "../"
}

dependency "monitor_diagnostic_storage" {
  config_path = "${get_repo_root()}/azure/comm/it/corp-logging-prod-01/monitor-diagnostic-storage"
}

inputs = {
  centralized_private_endpoints = {
    "pep-stparsonstfstatecomm" = {
      location          = "eastus2"
      resource_id       = dependency.resources.outputs.storage_accounts["stparsonstfstatecomm"].id
      subresource_names = ["blob"]
    }
    pep-adf-parsons-centralized-portal = {
      location          = "eastus2"
      resource_id       = dependency.resources.outputs.data_factories["adf-parsons-centralized-portal"].id
      subresource_names = ["portal"]
    }
  }
  monitor_diagnostic_destinations = dependency.monitor_diagnostic_storage.outputs.monitor_diagnostic_destinations
}
