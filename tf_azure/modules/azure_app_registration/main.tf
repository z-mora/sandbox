resource "azuread_application" "this" {
  display_name            = var.display_name
  prevent_duplicate_names = true

  dynamic "required_resource_access" {
    for_each = var.api_permissions
    content {
      resource_app_id = data.azuread_service_principal.api[required_resource_access.key].application_id

      dynamic "resource_access" {
        for_each = required_resource_access.value
        content {
          # Use the app role ID if there is one, otherwise use the OAuth2 permission scope ID
          id = try(
            data.azuread_service_principal.api[required_resource_access.key].app_role_ids[resource_access.value],
            data.azuread_service_principal.api[required_resource_access.key].oauth2_permission_scope_ids[resource_access.value]
          )
          type = (
            contains(keys(data.azuread_service_principal.api[required_resource_access.key].app_role_ids), resource_access.value)
            ? "Role" : "Scope"
          )
        }
      }
    }
  }

  dynamic "web" {
    for_each = var.web == null ? [] : [var.web]
    content {
      homepage_url  = web.value.homepage_url
      logout_url    = web.value.logout_url
      redirect_uris = web.value.redirect_uris

      dynamic "implicit_grant" {
        for_each = web.value.implicit_grant == null ? [] : [web.value.implicit_grant]
        content {
          access_token_issuance_enabled = implicit_grant.value.access_token_issuance_enabled
          id_token_issuance_enabled     = implicit_grant.value.id_token_issuance_enabled
        }
      }
    }
  }

  lifecycle {
    # Ignore owner for now, we may remove owners once we have Application Administrator role
    ignore_changes = [owners]
  }
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id

  lifecycle {
    # Ignore owner for now, we may remove owners once we have Application Administrator role
    ignore_changes = [owners]
  }
}

resource "time_rotating" "this" {
  for_each = { for k, v in var.secrets : k => v if v.auto_rotate_days != null }

  rotation_days = each.value.auto_rotate_days
}

resource "azuread_application_password" "this" {
  for_each = { for k, v in var.secrets : k => v if v.staggered_rotation == null }

  application_id    = azuread_application.this.id
  display_name      = each.key
  end_date_relative = each.value.end_date_relative
  rotate_when_changed = each.value.auto_rotate_days == null ? null : {
    rotation = time_rotating.this[each.key].id
  }
}

resource "azuread_application_certificate" "this" {
  for_each = var.certificates

  application_id    = azuread_application.this.id
  encoding          = each.value.encoding
  end_date          = each.value.end_date
  end_date_relative = each.value.end_date_relative
  type              = each.value.type
  value             = each.value.value
}

resource "vault_kv_secret_v2" "client_id" {
  for_each = { for k, v in var.secrets : k => v if v.staggered_rotation == null && v.vault != null }

  data_json           = jsonencode({ value = azuread_application.this.client_id })
  delete_all_versions = true
  mount               = each.value.vault.mount
  name                = "${each.value.vault.path}/client_id"
}

resource "vault_kv_secret_v2" "client_secret" {
  for_each = { for k, v in var.secrets : k => v if v.staggered_rotation == null && v.vault != null }

  data_json = jsonencode({
    value = azuread_application_password.this[each.key].value
  })
  delete_all_versions = true
  mount               = each.value.vault.mount
  name                = "${each.value.vault.path}/client_secret"
}

resource "vault_kv_secret_v2" "tenant_id" {
  for_each = { for k, v in var.secrets : k => v if v.staggered_rotation == null && v.vault != null }

  data_json = jsonencode({
    value = data.azuread_client_config.current.tenant_id
  })
  delete_all_versions = true
  mount               = each.value.vault.mount
  name                = "${each.value.vault.path}/tenant_id"
}
