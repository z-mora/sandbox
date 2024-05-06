output "okta_group_names" {
  value = [
    for role in var.roles :
    "aws_${var.is_gov ? "" : "comm_"}${var.account_id}_${aws_iam_role.this[role].name}"
  ]
  description = "What the name of the Okta group should be for parsons.us SAML setup"
}
