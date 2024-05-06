resource "aws_cloudwatch_log_group" "cw_log_group" {
  name_prefix       = "parsons_vpc_flowlog_" # need to test for unique name
  retention_in_days = var.flowlog_retention_days
  tags              = local.tags
}

resource "aws_cloudwatch_log_subscription_filter" "cw_log_sub_filter" {
  name            = "vpc_subscription_logfilter"
  role_arn        = aws_iam_role.cw_log_sub_filter_role.arn
  log_group_name  = aws_cloudwatch_log_group.cw_log_group.name
  filter_pattern  = ""
  destination_arn = local.log_aggregator_destination
}

resource "aws_flow_log" "vpc_flowlog" {
  vpc_id          = aws_vpc.vpc.id # assuming that using vpc_id automaticaly sets the "ResourceType"
  iam_role_arn    = aws_iam_role.flowlog_role.arn
  log_destination = aws_cloudwatch_log_group.cw_log_group.arn
  traffic_type    = var.flowlog_traffic_type
  tags            = local.tags
}

resource "aws_iam_role" "cw_log_sub_filter_role" {
  assume_role_policy = data.aws_iam_policy_document.cw_log_sub_assume_role_policy.json
  inline_policy {
    name = "flowlog_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["logs:PutLogEvents"]
          Effect   = "Allow"
          Resource = aws_cloudwatch_log_group.cw_log_group.arn
        },
      ]
    })
  }
  tags = local.tags
}

resource "aws_iam_role" "flowlog_role" {
  assume_role_policy = data.aws_iam_policy_document.flowlog_assume_role_policy.json
  inline_policy {
    name = "flowlog_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
          ]
          Effect   = "Allow"
          Resource = ["${aws_cloudwatch_log_group.cw_log_group.arn}:*"]
        },
      ]
    })
  }
  tags = local.tags
}
