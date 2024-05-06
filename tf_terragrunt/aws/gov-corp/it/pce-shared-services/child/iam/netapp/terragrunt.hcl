dependency "account" {
  config_path = "../../"
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  account_id = dependency.account.outputs.account_id
  iam_policies = {
    policy-netapp-cloud-insights = {
      description = "Policy for NetApp Cloud Insights"
      policy_yaml = file(
        "${get_repo_root()}/aws/shared_data/policies/netapp_cloud_insights.yaml"
      )
    }
  }
}
