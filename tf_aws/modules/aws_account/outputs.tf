output "govcloud_account_id" {
  # If this attribute doesn't have a value it can be null or "", need to account for both
  value = (
    aws_organizations_account.this.govcloud_id == null ? null :
    (
      aws_organizations_account.this.govcloud_id == "" ? null :
      aws_organizations_account.this.govcloud_id
    )
  )
  description = "The ID of the AWS GovCloud account that was created"
}

output "id" {
  value       = aws_organizations_account.this.id
  description = "The ID of the AWS account being managed"
}

output "name" {
  value       = aws_organizations_account.this.name
  description = "The name of the AWS account that was created"
}
