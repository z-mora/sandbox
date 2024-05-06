resource "aws_iam_policy" "ec2_ssm" {
  name = "policy_ec2_ssm_operations"
  tags = local.tags

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2messages:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "ssm:DescribeAssociation",
          "ssm:DescribeDocument",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:GetManifest",
          "ssm:UpdateInstanceInformation",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:PutInventory",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssmmessages:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = ["s3:GetObject"]
        Effect = "Allow"
        Resource = (var.is_gov ? [
          "arn:aws-us-gov:s3:::aws-ssm-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::aws-windows-downloads-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::amazon-ssm-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::amazon-ssm-packages-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::us-gov-east-1-birdwatcher-prod/*",
          "arn:aws-us-gov:s3:::aws-ssm-document-attachments-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::patch-baseline-snapshot-us-gov-east-1/*",
          "arn:aws-us-gov:s3:::aws-ssm-us-gov-west-1/*",
          "arn:aws-us-gov:s3:::aws-windows-downloads-us-gov-west-1/*",
          "arn:aws-us-gov:s3:::amazon-ssm-us-gov-west-1/*",
          "arn:aws-us-gov:s3:::amazon-ssm-packages-us-gov-west-1/*",
          "arn:aws-us-gov:s3:::us-gov-west-1-birdwatcher-prod/*",
          "arn:aws-us-gov:s3:::aws-ssm-document-attachments-us-gov-west-1/*",
          "arn:aws-us-gov:s3:::patch-baseline-snapshot-us-gov-west-1/*"
          ] : [
          "arn:aws:s3:::aws-ssm-us-east-1/*",
          "arn:aws:s3:::aws-windows-downloads-us-east-1/*",
          "arn:aws:s3:::amazon-ssm-us-east-1/*",
          "arn:aws:s3:::amazon-ssm-packages-us-east-1/*",
          "arn:aws:s3:::us-east-1-birdwatcher-prod/*",
          "arn:aws:s3:::aws-ssm-document-attachments-us-east-1/*",
          "arn:aws:s3:::patch-baseline-snapshot-us-east-1/*",
          "arn:aws:s3:::aws-ssm-us-west-2/*",
          "arn:aws:s3:::aws-windows-downloads-us-west-2/*",
          "arn:aws:s3:::amazon-ssm-us-west-2/*",
          "arn:aws:s3:::amazon-ssm-packages-us-west-2/*",
          "arn:aws:s3:::us-west-2-birdwatcher-prod/*",
          "arn:aws:s3:::aws-ssm-document-attachments-us-west-2/*",
          "arn:aws:s3:::patch-baseline-snapshot-us-west-1/*",
          "arn:aws:s3:::aws-ssm-me-south-1/*",
          "arn:aws:s3:::aws-windows-downloads-me-south-1/*",
          "arn:aws:s3:::amazon-ssm-me-south-1/*",
          "arn:aws:s3:::amazon-ssm-packages-me-south-1/*",
          "arn:aws:s3:::me-south-1-birdwatcher-prod/*",
          "arn:aws:s3:::aws-ssm-document-attachments-me-south-1/*",
          "arn:aws:s3:::patch-baseline-snapshot-me-south-1/*",
          "arn:aws:s3:::aws-patch-manager-me-south-1-a53fc9dce/*",
          "arn:aws:s3:::aws-ssm-ca-central-1/*",
          "arn:aws:s3:::aws-windows-downloads-ca-central-1/*",
          "arn:aws:s3:::amazon-ssm-ca-central-1/*",
          "arn:aws:s3:::amazon-ssm-packages-ca-central-1/*",
          "arn:aws:s3:::ca-central-1-birdwatcher-prod/*",
          "arn:aws:s3:::aws-ssm-document-attachments-ca-central-1/*",
          "arn:aws:s3:::patch-baseline-snapshot-ca-central-1/*"
        ])
      },
      {
        Action = [
          "s3:GetEncryptionConfiguration",
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Effect = "Allow"
        Resource = (var.is_gov ? [
          "arn:aws-us-gov:s3:::par-ssm-maintenance-logs-us-gov-east-1",
          "arn:aws-us-gov:s3:::par-ssm-maintenance-logs-us-gov-east-1/*"
          ] : [
          "arn:aws:s3:::par-ssm-maintenance-logs-us-east-1",
          "arn:aws:s3:::par-ssm-maintenance-logs-us-east-1/*"
        ])
      },
      {
        Action = [
          "s3:GetEncryptionConfiguration",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = (var.is_gov ? [
          "arn:aws-us-gov:s3:::par-ssm-automation-files-us-gov-east-1",
          "arn:aws-us-gov:s3:::par-ssm-automation-files-us-gov-east-1/*"
          ] : [
          "arn:aws:s3:::par-ssm-automation-files-us-east-1",
          "arn:aws:s3:::par-ssm-automation-files-us-east-1/*"
        ])
      },
      {
        Action = ["ssm:GetParameter"]
        Effect = "Allow"
        Resource = (var.is_gov ?
          ["arn:aws-us-gov:ssm:*:*:parameter/AmazonCloudWatch-*"] :
          ["arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"]
        )
      }
    ]
  })
}

resource "aws_iam_role" "ec2_ssm" {
  managed_policy_arns = [aws_iam_policy.ec2_ssm.arn]
  name                = "role_instance_profile_ec2_ssm_operations"
  tags                = local.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = ["sts:AssumeRole"]
      Effect = "Allow"
      Principal = {
        Service = ["ec2.amazonaws.com", "ssm.amazonaws.com"]
      }
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "instance_profile_ec2_ssm_operations"
  role = aws_iam_role.ec2_ssm.name
  tags = local.tags
}
