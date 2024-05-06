dependency "account" {
  config_path = "../../"
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  account_id = dependency.account.outputs.account_id
  iam_policies = {
    "policy-cohesity-ec2-backup" = {
      description = "Policy for cohesity to backup and recover ec2 instances"
      policy_yaml = file(
        "${get_repo_root()}/aws/shared_data/policies/cohesity_ec2_backup.yaml"
      )
    }
  }
}
