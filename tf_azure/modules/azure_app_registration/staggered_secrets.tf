resource "time_static" "first_run_timestamp" {
  for_each = local.staggered_rotation_secrets

  rfc3339 = plantimestamp()

  # Ignore so every plan doesn't try to recreate due to plantimestamp() changing
  lifecycle { ignore_changes = [rfc3339] }
}

resource "time_rotating" "staggered_secret_one" {
  for_each = local.staggered_rotation_secrets

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

resource "time_static" "staggered_secret_one_creation" {
  for_each = local.staggered_rotation_secrets

  rfc3339  = time_rotating.staggered_secret_one[each.key].rfc3339
  triggers = { rotation = time_rotating.staggered_secret_one[each.key].rfc3339 }
}

resource "time_static" "staggered_secret_one_deletion" {
  for_each = local.staggered_rotation_secrets

  rfc3339 = timeadd(
    time_rotating.staggered_secret_one[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours + each.value.staggered_rotation.overlap_hours}h"
  )
  triggers = { rotation = time_rotating.staggered_secret_one[each.key].rfc3339 }

  # Ensure every plan doesn't try to recreate since plantimestamp() will change
  lifecycle { ignore_changes = [rfc3339] }
}

resource "azuread_application_password" "staggered_secret_one" {
  for_each = {
    for k, v in local.staggered_rotation_secrets : k => v if(
      (
        timecmp(time_static.staggered_secret_one_creation[k].rfc3339, plantimestamp()) == -1 ||
        timecmp(time_static.staggered_secret_one_creation[k].rfc3339, plantimestamp()) == 0
      ) && timecmp(time_static.staggered_secret_one_deletion[k].rfc3339, plantimestamp()) == 1
    )
  }

  application_id = azuread_application.this.id
  display_name   = "${each.key}-one"
}

resource "time_rotating" "staggered_secret_two" {
  for_each = local.staggered_rotation_secrets

  rfc3339       = plantimestamp()
  rotation_days = each.value.staggered_rotation.rotate_days * 2

  # Ensure every plan doesn't try to recreate since plantimestamp() will change
  lifecycle { ignore_changes = [rfc3339] }
}

resource "time_static" "staggered_secret_two_creation" {
  for_each = local.staggered_rotation_secrets

  rfc3339 = timeadd(
    time_rotating.staggered_secret_two[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours - each.value.staggered_rotation.overlap_hours}h"
  )
  triggers = { rotation = time_rotating.staggered_secret_two[each.key].rfc3339 }
}

resource "time_static" "staggered_secret_two_deletion" {
  for_each = local.staggered_rotation_secrets

  rfc3339 = timeadd(
    time_rotating.staggered_secret_two[each.key].rfc3339,
    "${each.value.staggered_rotation.rotate_hours * 2}h"
  )
  triggers = { rotation = time_rotating.staggered_secret_two[each.key].rfc3339 }
}

resource "azuread_application_password" "staggered_secret_two" {
  for_each = {
    for k, v in local.staggered_rotation_secrets : k => v if(
      (
        timecmp(time_static.staggered_secret_two_creation[k].rfc3339, plantimestamp()) == -1 ||
        timecmp(time_static.staggered_secret_two_creation[k].rfc3339, plantimestamp()) == 0
      ) && timecmp(time_static.staggered_secret_two_deletion[k].rfc3339, plantimestamp()) == 1
    )
  }

  application_id = azuread_application.this.id
  display_name   = "${each.key}-two"
}

resource "vault_kv_secret_v2" "staggered_secret_one_client_id" {
  for_each = local.staggered_secret_one_with_vault

  data_json           = jsonencode({ value = azuread_application.this.client_id })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_one[each.key].display_name}/client_id"
}

resource "vault_kv_secret_v2" "staggered_secret_one_client_secret" {
  for_each = local.staggered_secret_one_with_vault

  data_json = jsonencode({
    value = azuread_application_password.staggered_secret_one[each.key].value
  })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_one[each.key].display_name}/client_secret"
}

resource "vault_kv_secret_v2" "staggered_secret_one_tenant_id" {
  for_each = local.staggered_secret_one_with_vault

  data_json = jsonencode({
    value = data.azuread_client_config.current.tenant_id
  })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_one[each.key].display_name}/tenant_id"
}

resource "vault_kv_secret_v2" "staggered_secret_two_client_id" {
  for_each = local.staggered_secret_two_with_vault

  data_json           = jsonencode({ value = azuread_application.this.client_id })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_two[each.key].display_name}/client_id"
}

resource "vault_kv_secret_v2" "staggered_secret_two_client_secret" {
  for_each = local.staggered_secret_two_with_vault

  data_json = jsonencode({
    value = azuread_application_password.staggered_secret_two[each.key].value
  })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_two[each.key].display_name}/client_secret"
}

resource "vault_kv_secret_v2" "staggered_secret_two_tenant_id" {
  for_each = local.staggered_secret_two_with_vault

  data_json = jsonencode({
    value = data.azuread_client_config.current.tenant_id
  })
  delete_all_versions = true
  mount               = var.secrets[each.key].vault.mount
  name                = "${var.secrets[each.key].vault.path}/${azuread_application_password.staggered_secret_two[each.key].display_name}/tenant_id"
}
