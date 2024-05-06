locals {
  is_external = var.internal_or_external == "external" ? true : false
}
