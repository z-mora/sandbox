variable "role_name" {
  type        = string
  description = "Name of the role"
}

variable "actions" {
  type        = list(string)
  description = "list of allowed actions"
}

variable "data_actions" {
  type        = list(string)
  description = "list of allowed data actions"
}

variable "not_actions" {
  type        = list(string)
  description = "list of disallowed actions"
}

variable "not_data_actions" {
  type        = list(string)
  description = "list of disallowed data actions"
}

variable "role_description" {
  type        = string
  description = "description of the role"
}

variable "scope" {
  type        = string
  description = "The scope at which the Role Definition applies to"
}
