variable "child_groups" {
  type        = map(any)
  description = <<EOL
  Nested child management groups to create under the current group. The type is
  ambiguous because these child groups can be nested up to 5 levels deep. The map key
  should be the child management group name.
  EOL
}

variable "name" {
  type        = string
  description = "Name of the parent management group"
}
