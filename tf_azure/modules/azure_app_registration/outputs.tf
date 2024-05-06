output "client_secrets" {
  value = merge(
    {
      for k, v in azuread_application_password.this : k => merge(v, {
        next_rotation = try(time_rotating.this[k].rotation_rfc3339, "N/A")
      })
    },
    # Make the keys below unique before merging
    {
      for k, v in azuread_application_password.staggered_secret_one : "${k}-one" =>
      merge(v, {
        expires = time_static.staggered_secret_one_deletion[k].rfc3339
      })
    },
    {
      for k, v in azuread_application_password.staggered_secret_two : "${k}-two" =>
      merge(v, {
        expires = time_static.staggered_secret_two_deletion[k].rfc3339
      })
    }
  )
  description = "A collection of client secret(s) (aka passwords) for the app registration"
  sensitive   = true
}

output "client_id" {
  value       = azuread_application.this.client_id
  description = "The Application/Client ID"
}

output "is_admin_consent_required" {
  value       = local.is_admin_consent_required
  description = "Will a global admin need to grant consent for the app registration's permissions"
}

output "object_id" {
  value       = azuread_application.this.object_id
  description = "The object ID of the app registration"
}

output "service_principal_id" {
  value       = azuread_service_principal.this.object_id
  description = "The object ID of the service principal associated with the app registration"
}
