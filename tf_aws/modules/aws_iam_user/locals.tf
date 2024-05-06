locals {
  # Convert days to hours because timeadd() doesn't support days
  staggered_rotation_keys = {
    for k, v in var.access_keys : k => merge(v, { staggered_rotation = merge(
      v.staggered_rotation, {
        overlap_hours = v.staggered_rotation.overlap_days * 24
        rotate_hours  = v.staggered_rotation.rotate_days * 24
      })
    }) if v.staggered_rotation != null
  }
  staggered_key_one_with_vault = {
    for k, v in aws_iam_access_key.staggered_key_one :
    k => v if var.access_keys[k].vault != null
  }
  staggered_key_two_with_vault = {
    for k, v in aws_iam_access_key.staggered_key_two :
    k => v if var.access_keys[k].vault != null
  }
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
}
