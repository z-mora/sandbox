include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "resources" {
  config_path = "../"
}

dependency "monitor_diagnostic_storage" {
  config_path = "${get_repo_root()}/azure/gov/it/corp-logging-01/monitor-diagnostic-storage"
}

inputs = {
  centralized_private_endpoints = {
    "pep-stparsonstfstategov" = {
      location          = "usgovvirginia"
      resource_id       = dependency.resources.outputs.storage_accounts["stparsonstfstategov"].id
      subresource_names = ["blob"]
    }
    pep-adf-parsons-centralized-portal = {
      location          = "usgovvirginia"
      resource_id       = dependency.resources.outputs.data_factories["adf-parsons-centralized-portal"].id
      subresource_names = ["portal"]
    }
  }
  monitor_diagnostic_destinations = dependency.monitor_diagnostic_storage.outputs.monitor_diagnostic_destinations
}
