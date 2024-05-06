locals {
  account_name  = replace(var.account_name, " ", "-")
  aws_partition = var.is_gov ? "aws-us-gov" : "aws"
  comm_metadata = file("${path.module}/metadata/comm_metadata.xml")
  gov_metadata  = file("${path.module}/metadata/gov_metadata.xml")
  iam_policies = {
    "account-admin" = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "access-analyzer:ValidatePolicy",
            "cloudtrail:DescribeTrails",
            "cloudtrail:Get*",
            "cloudtrail:List*",
            "cloudtrail:LookupEvents",
            "config:Describe*",
            "config:Get*",
            "config:List*",
            "ec2:Describe*",
            "ec2:Get*",
            "health:Describe*",
            "health:List*",
            "iam:Get*",
            "iam:List*",
            "iam:SimulateCustomPolicy",
            "iam:SimulatePrincipalPolicy",
            "ram:Get*",
            "ram:List*",
            "servicecatalog:Describe*",
            "servicecatalog:List*",
            "sts:DecodeAuthorizationMessage",
            "tag:Get*",
            "trustedadvisor:Describe*",
          ]
          Effect   = "Allow"
          Resource = "*"
          Sid      = "ReadOnlyPermissions"
        },
        {
          Action   = "iam:CreateServiceLinkedRole"
          Effect   = "Allow"
          Resource = "arn:${var.partition}:iam::*:role/aws-service-role/*"
          Sid      = "CreateServiceLinkedRoles"
        },
        {
          Action = [
            "iam:AddRoleToInstanceProfile",
            "iam:AttachRolePolicy",
            "iam:CreateInstanceProfile",
            "iam:CreatePolicy",
            "iam:CreatePolicyVersion",
            "iam:CreateRole",
            "iam:DeleteInstanceProfile",
            "iam:DeletePolicy",
            "iam:DeletePolicyVersion",
            "iam:DeleteRole",
            "iam:DeleteRolePolicy",
            "iam:DetachRolePolicy",
            "iam:PassRole",
            "iam:PutRolePolicy",
            "iam:RemoveRoleFromInstanceProfile",
            "iam:SetDefaultPolicyVersion",
          ]
          Effect   = "Allow"
          Resource = "*"
          Sid      = "RolesAndInstanceProfiles"
        },
        {
          Action = [
            "ec2:AllocateHosts",
            "ec2:AssignPrivateIpAddresses",
            "ec2:AssociateIamInstanceProfile",
            "ec2:AttachNetworkInterface",
            "ec2:AttachVolume",
            "ec2:AuthorizeSecurityGroup*",
            "ec2:CancelSpot*",
            "ec2:ConfirmProductInstance",
            "ec2:CopyImage",
            "ec2:CopySnapshot",
            "ec2:CreateFleet",
            "ec2:CreateImage",
            "ec2:CreateKeyPair",
            "ec2:CreateLaunchTemplate*",
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:CreatePlacementGroup",
            "ec2:CreateReplaceRootVolumeTask",
            "ec2:CreateSecurity*",
            "ec2:CreateSnapshot*",
            "ec2:CreateSpot*",
            "ec2:CreateTags",
            "ec2:CreateVolume",
            "ec2:CreateVpcEndpoint",
            "ec2:DeleteKeyPair",
            "ec2:DeleteLaunchTemplate*",
            "ec2:DeleteNetworkInterface",
            "ec2:DeletePlacementGroup",
            "ec2:DeleteSecurity*",
            "ec2:DeleteSnapshot",
            "ec2:DeleteSpot*",
            "ec2:DeleteTags",
            "ec2:DeleteVolume",
            "ec2:DeleteVpcEndpoints",
            "ec2:DeregisterImage",
            "ec2:DetachNetworkInterface",
            "ec2:DetachVolume",
            "ec2:DisassociateIamInstanceProfile",
            "ec2:GetConsoleOutput",
            "ec2:GetConsoleScreenshot",
            "ec2:GetPasswordData",
            "ec2:ImportKeyPair",
            "ec2:ModifyInstance*",
            "ec2:ModifyInstancePlacement",
            "ec2:ModifyLaunchTemplate",
            "ec2:ModifyNetworkInterfaceAttribute",
            "ec2:ModifySecurityGroupRules",
            "ec2:ModifySpot*",
            "ec2:ModifyVolume",
            "ec2:ModifyVolumeAttribute",
            "ec2:ModifyVpcEndpoint",
            "ec2:RebootInstances",
            "ec2:ReplaceIamInstanceProfileAssociation",
            "ec2:RequestSpot*",
            "ec2:RevokeSecurityGroup*",
            "ec2:StartInstances",
            "ec2:StopInstances",
            "ec2:TerminateInstances",
            "ec2:UpdateSecurityGroup*",
            "ec2-instance-connect:SendSerialConsoleSSHPublicKey",
            "ec2:RunInstances",
          ]
          Effect   = "Allow"
          Resource = "*"
          Sid      = "EC2Actions"
        },
        {
          Action = [
            "ec2:AttachVpnGateway",
            "ec2:CreateCustomerGateway",
            "ec2:CreateVpnGateway",
            "ec2:CreateVpnConnection",
            "ec2:CreateVpnConnectionRoute",
            "ec2:DeleteCustomerGateway",
            "ec2:DeleteVpnConnection",
            "ec2:DeleteVpnConnectionRoute",
            "ec2:DeleteVpnGateway",
            "ec2:DetachVpnGateway",
            "ec2:EnableVgwRoutePropagation",
            "ec2:GetVpnConnectionDeviceSampleConfiguration",
            "ec2:GetVpnConnectionDeviceTypes",
            "ec2:ModifyVpnConnection",
            "ec2:ModifyVpnConnectionOptions",
            "ec2:ModifyVpnTunnelCertificate",
            "ec2:ModifyVpnTunnelOptions",
          ]
          Effect   = "Allow"
          Resource = "*"
          Sid      = "VPNGW"
        },
        {
          Action = [
            "acm:*",
            "acm-pca:*",
            "airflow:*",
            "apigateway:*",
            "application-autoscaling:*",
            "athena:*",
            "autoscaling:*",
            "autoscaling-plans:*",
            "aws-portal:ViewAccount",
            "aws-portal:ViewBilling",
            "aws-portal:ViewUsage",
            "backup:*",
            "batch:*",
            "bedrock:*",
            "budgets:*",
            "ce:*",
            "cloudformation:*",
            "cloudfront:*",
            "cloudshell:*",
            "cloudwatch:*",
            "codebuild:*",
            "codepipeline:*",
            "cognito-identity:*",
            "cognito-idp:*",
            "cognito-snyc:*",
            "compute-optimizer:*",
            "cur:*",
            "databrew:*",
            "dlm:*",
            "dynamodb:*",
            "ecr:*",
            "ecs:*",
            "eks:*",
            "elasticache:*",
            "elasticbeanstalk:*",
            "elasticfilesystem:*",
            "elasticloadbalancing:*",
            "es:*",
            "events:*",
            "execute-api:*",
            "firehose:*",
            "fsx:*",
            "glacier:*",
            "glue:*",
            "imagebuilder:*",
            "kinesis:*",
            "kinesisanalytics:*",
            "kms:*",
            "lakeformation:*",
            "lambda:*",
            "logs:*",
            "mq:*",
            "outposts:*",
            "pi:*",
            "q:*",
            "quicksight:*",
            "rds:*",
            "redshift:*",
            "resource-explorer:*",
            "route53:*",
            "route53domains:*",
            "s3:*",
            "s3-outposts:*",
            "sagemaker:*",
            "secretsmanager:*",
            "servicediscovery:*",
            "ses:*",
            "snowball:*",
            "snow-device-management:*",
            "sns:*",
            "sqs:*",
            "ssm:*",
            "states:*",
            "storagegateway:*",
            "support:*",
            "waf-regional:*",
            "wafv2:*",
            "xray:*",
          ]
          Effect   = "Allow"
          Resource = "*"
          Sid      = "AllServices"
        },
      ]
    }
    "billing" = {
      Version = "2012-10-17"
      Statement = [
        {
          "Action" = [
            "account:GetAccountInformation",
            "account:GetAlternateContact",
            "account:GetContactInformation",
            "billing:Get*",
            "billing:RedeemCredits",
            "budgets:*",
            "consolidatedbilling:Get*",
            "consolidatedbilling:List*",
            "cur:*",
            "ce:*",
            "freetier:*",
            "health:Describe*",
            "iam:ListRoles",
            "invoicing:Get*",
            "invoicing:List*",
            "notifications:Get*",
            "notifications:List*",
            "payments:Get*",
            "payments:List*",
            "purchase-orders:Get*",
            "purchase-orders:List*",
            "savingsplans:*",
            "tax:Get*",
            "tax:List*"
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "BillingPermissions"
        },
        {
          "Action" = [
            "support:DescribeAttachment",
            "support:DescribeCommunications",
            "support:AddCommunicationToCase",
            "support:AddAttachmentsToSet",
            "support:CreateCase",
            "support:Describe*",
            "support:InitiateCallForCase",
            "support:InitiateChatForCase",
            "support:PutCaseAttributes",
            "support:RateCaseCommunication",
            "support:RefreshTrustedAdvisorCheck",
            "support:ResolveCase",
            "support:SearchForCases",
            "trustedadvisor:Describe*"
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "SupportAccess"
        }
      ]
    }
    "ctf-limited" = {
      Version = "2012-10-17"
      Statement = [
        {
          "Action" = [
            "cloudfront:Get*",
            "cloudfront:List*",
            "cloudtrail:DescribeTrails",
            "cloudtrail:Get*",
            "cloudtrail:List*",
            "cloudtrail:LookupEvents",
            "compute-optimizer:Describe*",
            "compute-optimizer:Get*",
            "config:Describe*",
            "config:Get*",
            "config:List*",
            "ec2:Describe*",
            "ec2:Get*",
            "health:Describe*",
            "health:List*",
            "iam:Get*",
            "iam:List*",
            "iam:SimulateCustomPolicy",
            "iam:SimulatePrincipalPolicy",
            "ram:Get*",
            "ram:List*",
            "servicecatalog:Describe*",
            "servicecatalog:List*",
            "tag:Get*",
            "trustedadvisor:Describe*",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "ReadOnlyPermissions"
        },
        {
          "Action"   = "iam:CreateServiceLinkedRole",
          "Resource" = "arn:${local.aws_partition}:iam::*:role/aws-service-role/*",
          "Effect"   = "Allow",
          "Sid"      = "CreateServiceLinkedRoles"
        },
        {
          "Action" = [
            "iam:AddRoleToInstanceProfile",
            "iam:AttachRolePolicy",
            "iam:CreateInstanceProfile",
            "iam:CreatePolicy",
            "iam:CreatePolicyVersion",
            "iam:CreateRole",
            "iam:DeleteInstanceProfile",
            "iam:DeletePolicy",
            "iam:DeletePolicyVersion",
            "iam:DeleteRole",
            "iam:DeleteRolePolicy",
            "iam:DetachRolePolicy",
            "iam:PassRole",
            "iam:PutRolePolicy",
            "iam:RemoveRoleFromInstanceProfile",
            "iam:SetDefaultPolicyVersion",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "RolesAndInstanceProfiles"
        },
        {
          "Action" = [
            "ec2-instance-connect:SendSerialConsoleSSHPublicKey",
            "ec2:AllocateAddress",
            "ec2:AllocateHosts",
            "ec2:AssignPrivateIpAddresses",
            "ec2:AssociateAddress",
            "ec2:AssociateIamInstanceProfile",
            "ec2:AttachNetworkInterface",
            "ec2:AttachVolume",
            "ec2:AuthorizeSecurityGroup*",
            "ec2:CancelSpot*",
            "ec2:ConfirmProductInstance",
            "ec2:CopyImage",
            "ec2:CopySnapshot",
            "ec2:CreateFleet",
            "ec2:CreateImage",
            "ec2:CreateKeyPair",
            "ec2:CreateLaunchTemplate*",
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:CreatePlacementGroup",
            "ec2:CreateReplaceRootVolumeTask",
            "ec2:CreateSecurity*",
            "ec2:CreateSnapshot*",
            "ec2:CreateSpot*",
            "ec2:CreateTags",
            "ec2:CreateVolume",
            "ec2:DeleteKeyPair",
            "ec2:DeleteLaunchTemplate*",
            "ec2:DeleteNetworkInterface",
            "ec2:DeletePlacementGroup",
            "ec2:DeleteSecurity*",
            "ec2:DeleteSnapshot",
            "ec2:DeleteSpot*",
            "ec2:DeleteTags",
            "ec2:DeleteVolume",
            "ec2:DeregisterImage",
            "ec2:DetachNetworkInterface",
            "ec2:DetachVolume",
            "ec2:DisassociateAddress",
            "ec2:DisassociateIamInstanceProfile",
            "ec2:GetConsoleOutput",
            "ec2:GetConsoleScreenshot",
            "ec2:GetPasswordData",
            "ec2:ImportKeyPair",
            "ec2:ModifyInstance*",
            "ec2:ModifyInstancePlacement",
            "ec2:ModifyLaunchTemplate",
            "ec2:ModifyNetworkInterfaceAttribute",
            "ec2:ModifySpot*",
            "ec2:ModifyVolume",
            "ec2:ModifyVolumeAttribute",
            "ec2:RebootInstances",
            "ec2:ReleaseAddress",
            "ec2:ReplaceIamInstanceProfileAssociation",
            "ec2:RequestSpot*",
            "ec2:RevokeSecurityGroup*",
            "ec2:RunInstances",
            "ec2:StartInstances",
            "ec2:StopInstances",
            "ec2:TerminateInstances",
            "ec2:UpdateSecurityGroup*",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "EC2Actions"
        },
        {
          "Action" = [
            "ec2:CreateVpcEndpoint",
            "ec2:DeleteVpcEndpoints",
            "ec2:ModifyVpcEndpoint",
          ],
          "Resource" = [
            "arn:${local.aws_partition}:ec2:*:*:vpc/*",
            "arn:${local.aws_partition}:ec2:*:*:vpc-endpoint/*",
            "arn:${local.aws_partition}:ec2:*:*:route-table/*",
            "arn:${local.aws_partition}:ec2:*:*:security-group/*",
            "arn:${local.aws_partition}:ec2:*:*:subnet/*"
          ],
          "Effect" = "Allow",
          "Sid"    = "VPCEndpoints"
        },
        {
          "Action" = [
            "aws-portal:ViewAccount",
            "aws-portal:ViewBilling",
            "aws-portal:ViewUsage",
            "budgets:*",
            "ce:*",
            "cloudformation:*",
            "compute-optimizer:*",
            "kms:*",
            "lambda:*",
            "rds:*",
            "s3:*",
            "sns:*",
            "ssm:*",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "AllServices"
        },
      ]
    }
    "full-admin" = {
      Version = "2012-10-17"
      Statement = [
        {
          NotAction = ["directconnect:*"]
          Effect    = "Allow"
          Resource  = "*"
          Sid       = "AllowAllExceptDirectConnect"
        },
      ]
    }
    "route53-parsons-cyber" = {
      Version = "2012-10-17"
      Statement = [
        {
          "Action" = [
            "route53:GetHostedZoneCount",
            "route53:ListHostedZones*",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "ListHostedZonesActions"
        },
        {
          "Action" = [
            "route53:ChangeResourceRecordSets",
            "route53:GetHostedZone",
            "route53:GetHostedZoneLimit",
            "route53:ListResourceRecordSets",
          ],
          "Resource" = "arn:aws:route53:::hostedzone/Z05529553Q8XFC0ZJRXYO",
          "Effect"   = "Allow",
          "Sid"      = "SpecificHostedZoneActions"
        }
      ]
    }
    "route53-parsons-games" = {
      Version = "2012-10-17"
      Statement = [
        {
          "Action" = [
            "route53:GetHostedZoneCount",
            "route53:ListHostedZones*",
          ],
          "Resource" = "*",
          "Effect"   = "Allow",
          "Sid"      = "ListHostedZonesActions"
        },
        {
          "Action" = [
            "route53:ChangeResourceRecordSets",
            "route53:GetHostedZone",
            "route53:GetHostedZoneLimit",
            "route53:ListResourceRecordSets",
          ],
          "Resource" = "arn:aws:route53:::hostedzone/Z02501941KJVVTHCHCCLB",
          "Effect"   = "Allow",
          "Sid"      = "SpecificHostedZoneActions"
        }
      ]
    }
  }
  role_type = {
    "account-admin"         = "ADMIN"
    "billing"               = "BILLING"
    "ctf-limited"           = "CTF-LIMITED"
    "full-admin"            = "FULL-ADMIN"
    "route53-parsons-cyber" = "ROUTE53-PARSONSCYBER"
    "route53-parsons-games" = "ROUTE53-PARSONSGAMES"
  }
  saml_partition_url = "https://signin.${var.is_gov ? "amazonaws-us-gov" : "aws.amazon"}.com/saml"
}
