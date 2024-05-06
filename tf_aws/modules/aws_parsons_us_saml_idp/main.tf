resource "aws_iam_saml_provider" "this" {
  name                   = "ParsonsOktaSAMLSSO"
  saml_metadata_document = var.is_gov ? local.gov_metadata : local.comm_metadata
  tags                   = var.tags
}

resource "aws_iam_role" "this" {
  for_each = var.roles

  name = "${local.account_name}-${local.role_type[each.value]}-Role"
  tags = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithSAML"
        Condition = {
          StringEquals = {
            "SAML:aud" = local.saml_partition_url
          }
        }
        Effect = "Allow"
        Principal = {
          Federated = "arn:${var.partition}:iam::${var.account_id}:saml-provider/ParsonsOktaSAMLSSO"
        }
      },
    ]
  })
}


resource "aws_iam_policy" "this" {
  for_each = var.roles

  name   = "iam-policy-parsons-us-saml-${each.value}"
  path   = "/"
  policy = jsonencode(local.iam_policies[each.value])
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.roles

  role       = aws_iam_role.this[each.value].name
  policy_arn = aws_iam_policy.this[each.value].arn
}
