resource "time_static" "first_run_timestamp" {
  for_each = local.staggered_rotation_keys

  rfc3339 = plantimestamp()

  # Ignore so every plan doesn't try to recreate due to plantimestamp() changing
  lifecycle { ignore_changes = [rfc3339] }
}

resource "time_rotating" "staggered_key_one" {
  for_each = local.staggered_rotation_keys

  # On the first run start the rotation in the past so the rotation starts staggered
  rfc3339 = (
    time_static.first_run_timestamp[each.key].rfc3339 == plantimestamp() ?
    timeadd(plantimestamp(), "-${each.value.staggered_rotation.overlap_hours}h") :
    plantimestamp()
  )
  rotation_days = each.value.staggered_rotation.rotate_days * 2

  # Ensure every plan doesn't try to recreate since plantimestamp() will change
  lifecycle { ignore_changes = [rfc3339] }
}

resource "time_static" "staggered_key_one_creation" {
  for_each = local.staggered_rotation_keys

  rfc3339  = time_rotating.staggered_key_one[each.key].rfc3339
  triggers = { rotation = time_rotating.staggered_key_one[each.key].rfc3339 }
}

resource "time_static" "staggered_key_one_deletion" {
  for_each = local.staggered_rotation_keys

  rfc3339 = timeadd(
    time_rotating.staggered_key_one[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours + each.value.staggered_rotation.overlap_hours}h"
  )
  triggers = { rotation = time_rotating.staggered_key_one[each.key].rfc3339 }

  # Ensure every plan doesn't try to recreate since plantimestamp() will change
  lifecycle { ignore_changes = [rfc3339] }
}

resource "aws_iam_access_key" "staggered_key_one" {
  for_each = {
    for k, v in local.staggered_rotation_keys : k => v if(
      (
        timecmp(time_static.staggered_key_one_creation[k].rfc3339, plantimestamp()) == -1 ||
        timecmp(time_static.staggered_key_one_creation[k].rfc3339, plantimestamp()) == 0
      ) && timecmp(time_static.staggered_key_one_deletion[k].rfc3339, plantimestamp()) == 1
    )
  }

  status = each.value.status
  user   = aws_iam_user.this.name
}

resource "time_rotating" "staggered_key_two" {
  for_each = local.staggered_rotation_keys

  rfc3339       = plantimestamp()
  rotation_days = each.value.staggered_rotation.rotate_days * 2

  # Ensure every plan doesn't try to recreate since plantimestamp() will change
  lifecycle { ignore_changes = [rfc3339] }
}

resource "time_static" "staggered_key_two_creation" {
  for_each = local.staggered_rotation_keys

  rfc3339 = timeadd(
    time_rotating.staggered_key_two[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours - each.value.staggered_rotation.overlap_hours}h"
  )
  triggers = { rotation = time_rotating.staggered_key_two[each.key].rfc3339 }
}

resource "time_static" "staggered_key_two_deletion" {
  for_each = local.staggered_rotation_keys

  rfc3339 = timeadd(
    time_rotating.staggered_key_two[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours * 2}h"
  )
  triggers = { rotation = time_rotating.staggered_key_two[each.key].rfc3339 }
}

resource "aws_iam_access_key" "staggered_key_two" {
  for_each = {
    for k, v in local.staggered_rotation_keys : k => v if(
      (
        timecmp(time_static.staggered_key_two_creation[k].rfc3339, plantimestamp()) == -1 ||
        timecmp(time_static.staggered_key_two_creation[k].rfc3339, plantimestamp()) == 0
      ) && timecmp(time_static.staggered_key_two_deletion[k].rfc3339, plantimestamp()) == 1
    )
  }

  status = each.value.status
  user   = aws_iam_user.this.name
}

resource "vault_kv_secret_v2" "staggered_key_one_access_key_id" {
  for_each = local.staggered_key_one_with_vault

  data_json           = jsonencode({ value = aws_iam_access_key.staggered_key_one[each.key].id })
  delete_all_versions = true
  mount               = var.access_keys[each.key].vault.mount
  name                = "${var.access_keys[each.key].vault.path}/${each.key}-one/access_key_id"
}

resource "vault_kv_secret_v2" "staggered_key_one_secret_access_key" {
  for_each = local.staggered_key_one_with_vault

  data_json           = jsonencode({ value = aws_iam_access_key.staggered_key_one[each.key].secret })
  delete_all_versions = true
  mount               = var.access_keys[each.key].vault.mount
  name                = "${var.access_keys[each.key].vault.path}/${each.key}-one/secret_access_key"
}

resource "vault_kv_secret_v2" "staggered_key_two_access_key_id" {
  for_each = local.staggered_key_two_with_vault

  data_json           = jsonencode({ value = aws_iam_access_key.staggered_key_two[each.key].id })
  delete_all_versions = true
  mount               = var.access_keys[each.key].vault.mount
  name                = "${var.access_keys[each.key].vault.path}/${each.key}-two/access_key_id"
}

resource "vault_kv_secret_v2" "staggered_key_two_secret_access_key" {
  for_each = local.staggered_key_two_with_vault

  data_json           = jsonencode({ value = aws_iam_access_key.staggered_key_two[each.key].secret })
  delete_all_versions = true
  mount               = var.access_keys[each.key].vault.mount
  name                = "${var.access_keys[each.key].vault.path}/${each.key}-two/secret_access_key"
}
