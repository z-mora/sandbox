locals {
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )

  root_policies = { for policy in try(var.organizational_units.Root.policies, {}) :
    "Root=${policy}" => { policy = policy }
  }

  level2_ou = merge([for l1_key, l1_value in var.organizational_units : {
    for l2_key, l2_value in l1_value : "${l1_key}:${l2_key}" => {
      parent_name = l1_key
      ou_name     = l2_key
      children    = l2_value
      policies    = try(l2_value.policies, {})
    } if l2_key != "policies"
  }]...)

  level3_ou = merge([for l2_key, l2_value in local.level2_ou : {
    for l3_key, l3_value in l2_value.children : "${l2_key}:${l3_key}" => {
      parent_name = l2_key,
      ou_name     = l3_key,
      children    = l3_value,
      policies    = try(l3_value.policies, {})
    } if l3_key != "policies"
  }]...)

  level4_ou = merge([for l3_key, l3_value in local.level3_ou : {
    for l4_key, l4_value in l3_value.children : "${l3_key}:${l4_key}" => {
      parent_name = l3_key,
      ou_name     = l4_key,
      children    = l4_value,
      policies    = try(l4_value.policies, {})
    } if l4_key != "policies"
  }]...)

  all_ous = merge(local.level2_ou, local.level3_ou, local.level4_ou)

  all_policies = merge([for k, v in local.all_ous : {
    for policy in v.policies :
    "${k}=${policy}" => { ou_key = k, policy = policy }
  }]...)
}
