include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "storage" {
  config_path = "../"
}

inputs = {
  role_assignments = {
    "Grant access to stpowerbisevenprogram" = {
      role_name = "role-parsons-alz-admin"
      scope = {
        id = dependency.storage.outputs.storage_accounts["stpowerbisevenprogram"].id
      }
      user_principal_names = [
        "mohamed.sabbah@parsons.com",
      ]
    }
  }
}
