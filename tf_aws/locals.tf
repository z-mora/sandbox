locals {
  account_id = var.account_id != null ? var.account_id : module.aws_account[0].id
  account_name = (
    var.account_id == null ? module.aws_account[0].name : [
      for a in data.aws_organizations_organization.current.accounts :
      a.name if a.id == var.account_id
  ][0])
  corp_org_ids = [
    "o-xkwln3lsqp", # Corp IT Commercial
    "o-26sd3vo7gj", # Corp IT GovCloud Parent
    "o-bty1f0zk8i", # Corp IT GovCloud Child
  ]
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  default_tags = merge(
    { for k, v in var.default_tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.default_tags["JobWbs"] },
    { Source = "Terraform" }
  )
  is_corp_account = local.is_network_account || contains(
    local.corp_org_ids, data.aws_organizations_organization.current.id
  )
  is_gov             = data.aws_partition.current.partition == "aws-us-gov" ? true : false
  is_network_account = strcontains(lower(local.account_name), "network")
}
