resource "aws_iam_user" "this" {
  name = var.name
  path = var.path
  tags = local.tags
}

resource "aws_iam_user_group_membership" "this" {
  user   = aws_iam_user.this.name
  groups = [for name in var.groups : name]
}

resource "aws_iam_access_key" "no_auto_rotate" {
  for_each = {
    for k, v in var.access_keys :
    k => v if v.staggered_rotation == null && v.auto_rotate_days == null
  }

  status = each.value.status
  user   = aws_iam_user.this.name
}

resource "time_rotating" "this" {
  for_each = { for k, v in var.access_keys : k => v if v.auto_rotate_days != null }

  rotation_days = each.value.auto_rotate_days
}

# time_rotating doesn't work with replace_triggered_by on its own. See:
# https://github.com/hashicorp/terraform-provider-time/issues/118
resource "time_static" "this" {
  for_each = time_rotating.this

  rfc3339 = each.value.rfc3339
}


resource "aws_iam_access_key" "auto_rotate" {
  for_each = { for k, v in var.access_keys : k => v if v.auto_rotate_days != null }

  status = each.value.status
  user   = aws_iam_user.this.name

  lifecycle {
    replace_triggered_by = [time_static.this[each.key]]
  }
}

resource "vault_kv_secret_v2" "access_key_id" {
  for_each = {
    for k, v in var.access_keys :
    k => v if v.staggered_rotation == null && v.vault != null
  }

  data_json = jsonencode({
    value = try(
      aws_iam_access_key.no_auto_rotate[each.key].id,
      aws_iam_access_key.auto_rotate[each.key].id
    )
  })
  delete_all_versions = true
  mount               = each.value.vault.mount
  name                = "${each.value.vault.path}/access_key_id"
}

resource "vault_kv_secret_v2" "secret_access_key" {
  for_each = {
    for k, v in var.access_keys :
    k => v if v.staggered_rotation == null && v.vault != null
  }

  data_json = jsonencode({
    value = try(
      aws_iam_access_key.no_auto_rotate[each.key].secret,
      aws_iam_access_key.auto_rotate[each.key].secret
    )
  })
  delete_all_versions = true
  mount               = each.value.vault.mount
  name                = "${each.value.vault.path}/secret_access_key"
}
