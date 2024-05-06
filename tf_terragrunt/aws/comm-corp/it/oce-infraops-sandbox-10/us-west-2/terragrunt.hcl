dependency "account" {
  config_path = "../"
  mock_outputs = {
    account_id = local.is_govcloud ? "305662966459" : "396156139991"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  account_id = dependency.account.outputs.account_id
}

locals {
  is_govcloud = length(regexall("child", get_terragrunt_dir())) > 0 ? true : false
}
