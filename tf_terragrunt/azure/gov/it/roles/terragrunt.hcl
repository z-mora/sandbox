dependency "management_groups" {
  config_path  = "${get_repo_root()}/azure/gov/it/management-groups"
  skip_outputs = true
}

include "root" {
  path = find_in_parent_folders("azure.hcl")
}
