iam_groups = {
  group-netapp-cloud-insights = {
    policy_keys = ["policy-netapp-cloud-insights"]
  }
}

iam_users = {
  _sys_netapp_cloud_insights = {
    group_keys = ["group-netapp-cloud-insights"]
  }
}
