variable "name" {
  type        = string
  description = <<-EOL
  The group's name. The name must consist of upper and lowercase alphanumeric characters
  with no spaces. You can also include any of the following characters: =,.@-_..
  Group names are not distinguished by case. For example, you cannot create groups named
  both "ADMINS" and "admins".
  EOL
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the group."
}

variable "policies" {
  type        = map(string)
  default     = {}
  description = <<-EOL
  A map of policies to attach to the group. The key is the key of the policy and the
  value is the ARN.
  EOL
}
