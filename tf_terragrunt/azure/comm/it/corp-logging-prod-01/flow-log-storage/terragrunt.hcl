include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "monitor_diagnostic_storage" {
  config_path = "../monitor-diagnostic-storage"
}

inputs = {
  monitor_diagnostic_destinations = dependency.monitor_diagnostic_storage.outputs.monitor_diagnostic_destinations
}
