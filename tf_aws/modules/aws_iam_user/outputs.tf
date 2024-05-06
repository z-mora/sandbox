output "access_keys" {
  value = merge(
    {
      for k, v in aws_iam_access_key.no_auto_rotate : k => merge(v, {
        expires = "never"
      })
    },
    {
      for k, v in aws_iam_access_key.auto_rotate : k => merge(v, {
        next_rotation = time_rotating.this[k].rotation_rfc3339
      })
    },
    # Make the keys below unique before merging
    {
      for k, v in aws_iam_access_key.staggered_key_one : "${k}-one" => merge(v, {
        expires = time_static.staggered_key_one_deletion[k].rfc3339
      })
    },
    {
      for k, v in aws_iam_access_key.staggered_key_two : "${k}-two" => merge(v, {
        expires = time_static.staggered_key_two_deletion[k].rfc3339
      })
    }
  )
  description = "The IAM access keys for the user"
  sensitive   = true
}

output "arn" {
  value       = aws_iam_user.this.arn
  description = "The ARN of the user that was created"
}
