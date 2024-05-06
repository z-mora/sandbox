dependencies {
  paths = [
    "${get_repo_root()}/azure/comm/it/management-groups",
  ]
}

include "root" {
  path = find_in_parent_folders("azure.hcl")
}
