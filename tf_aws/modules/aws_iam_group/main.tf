resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_policy_attachment" "this" {
  for_each = var.policies

  group      = aws_iam_group.this.name
  policy_arn = each.value
}
