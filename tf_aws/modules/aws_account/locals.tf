locals {
  is_corp = contains([
    "o-xkwln3lsqp", # Corp IT Commercial
    "o-26sd3vo7gj", # Corp IT GovCloud Parent
    "o-bty1f0zk8i", # Corp IT GovCloud Child
    "o-uhhgp0bexb", # ParPro (until FinOps can figure out tagging for this org)
  ], var.organization_id)
  is_network_account = strcontains(lower(var.name), "network")
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  # Job/WBS should have no value for non-network Corp accounts, per FinOps
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = local.is_corp && !local.is_network_account ? "" : var.tags["JobWbs"] }
  )
}
