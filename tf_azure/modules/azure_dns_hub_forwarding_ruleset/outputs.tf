output "id" {
  description = "The ID of the forwarding ruleset"
  value       = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
}

output "location" {
  description = "The region of the forwarding ruleset"
  value       = var.location
}
