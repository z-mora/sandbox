resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
}

resource "aws_organizations_policy" "this" {
  for_each = var.policies

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = local.tags
}

resource "aws_organizations_policy_attachment" "root" {
  for_each = local.root_policies

  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = aws_organizations_organization.org.roots[0].id
}



resource "aws_organizations_policy_attachment" "all" {
  for_each = local.all_policies

  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = try(
    aws_organizations_organizational_unit.level_2[each.value.ou_key].id,
    aws_organizations_organizational_unit.level_3[each.value.ou_key].id,
    aws_organizations_organizational_unit.level_4[each.value.ou_key].id
  )
}

resource "aws_organizations_organizational_unit" "level_2" {
  for_each = local.level2_ou

  name      = each.value.ou_name
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "level_3" {
  for_each = local.level3_ou

  name      = each.value.ou_name
  parent_id = aws_organizations_organizational_unit.level_2[each.value.parent_name].id
}

resource "aws_organizations_organizational_unit" "level_4" {
  for_each = local.level4_ou

  name      = each.value.ou_name
  parent_id = aws_organizations_organizational_unit.level_3[each.value.parent_name].id
}
