iam_groups = {
  group-cohesity-ec2-backup = {
    policy_keys = ["policy-cohesity-ec2-backup"]
  }
}

iam_users = {
  _sys_cohesity_ec2_backup = {
    access_keys = {
      cohesity = {
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "team_cloud/cohesity/aws/comm/security/_sys_cohesity_ec2_backup"
        }
      }
    }
    group_keys = ["group-cohesity-ec2-backup"]
  }
}
