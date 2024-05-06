role_assignments = {
  "Grant managed identity access to DNS sub" = {
    managed_identity_keys = ["id-private-endpoint-dns-configuration"]
    role_name             = "Private DNS Zone Contributor"
    scope = {
      display_name = "sub-comm-corp-dns-01"
      type         = "subscription"
    }
  }
  "Assign Network Contributor to managed identity" = {
    managed_identity_keys = ["id-private-endpoint-dns-configuration"]
    role_name             = "Network Contributor"
    scope = {
      display_name = "Parsons"
      type         = "management_group"
    }
  }
}
