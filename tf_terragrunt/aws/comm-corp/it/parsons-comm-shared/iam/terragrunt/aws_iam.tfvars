iam_groups = {
  group-aws-terragrunt-admin = {
    policy_keys = ["policy-terragrunt-admin"]
  }
}

iam_users = {
  _sys_terragrunt_admin = {
    access_keys = {
      jenkins = {
        auto_rotate_days = 30
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "team_cloud/aws/comm/_sys_terragrunt_admin"
        }
      }
    }
    group_keys = ["group-aws-terragrunt-admin"]
  }
}
