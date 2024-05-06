output "arn" {
  value       = aws_iam_policy.this.arn
  description = "The ARN of the policy that was created"
}

output "name" {
  value       = aws_iam_policy.this.name
  description = <<-EOL
  The name of the policy that was created. This will differ from the policy key if a
  `name_prefix` was provided.
  EOL
}
