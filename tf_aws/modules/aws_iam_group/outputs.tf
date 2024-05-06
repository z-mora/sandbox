output "arn" {
  value       = aws_iam_group.this.arn
  description = "The ARN of the group that was created"
}

output "id" {
  value       = aws_iam_group.this.id
  description = "The ID of the group that was created"
}

output "name" {
  value       = aws_iam_group.this.name
  description = "The name of the group that was created"
}
