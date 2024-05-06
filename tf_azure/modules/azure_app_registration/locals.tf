locals {
  # Get the permission scopes from the API
  permission_scopes = flatten([
    for api, permissions in var.api_permissions : [
      for user_provided_permission in permissions : [
        for scope in data.azuread_service_principal.api[api].oauth2_permission_scopes :
        scope if scope.value == user_provided_permission
      ]
    ]
  ])

  is_admin_consent_required = anytrue([
    for scope in local.permission_scopes : scope.type == "Admin"
  ])
  staggered_rotation_secrets = {
    for k, v in var.secrets : k => merge(v, { staggered_rotation = merge(
      v.staggered_rotation, {
        overlap_hours = v.staggered_rotation.overlap_days * 24
        rotate_hours  = v.staggered_rotation.rotate_days * 24
      })
    }) if v.staggered_rotation != null
  }
  staggered_secret_one_with_vault = {
    for k, v in azuread_application_password.staggered_secret_one :
    k => v if var.secrets[k].vault != null
  }
  staggered_secret_two_with_vault = {
    for k, v in azuread_application_password.staggered_secret_two :
    k => v if var.secrets[k].vault != null
  }
}
