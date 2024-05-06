dependency "account" {
  config_path = "../../"
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  account_id = dependency.account.outputs.account_id
  iam_policies = {
    policy-terragrunt-admin = {
      description = "Policy Assume Role for Terragrunt Admin Plan and Apply"
      policy_yaml = file(
        "${get_repo_root()}/aws/shared_data/policies/terragrunt_admin.yaml"
      )
    }
  }
}
