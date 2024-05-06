dependency "account" {
  config_path = "../"
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  account_id = dependency.account.outputs.account_id
}
