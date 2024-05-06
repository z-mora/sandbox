resource "aws_iam_policy" "this" {
  description = var.description
  name        = var.name_prefix == null ? var.name : null
  name_prefix = var.name_prefix
  path        = var.path
  policy = try(
    data.aws_iam_policy_document.from_hcl[0].json,
    data.aws_iam_policy_document.from_yaml[0].json
  )
  tags = local.tags
}
