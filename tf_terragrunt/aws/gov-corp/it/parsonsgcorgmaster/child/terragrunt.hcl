# Since this account was created outside of Terraform and imported, the parent account
# doesn't have an attribute for govcloud_account_id

dependency "parent" {
  config_path = "../parent"
}

# Until Terraform 1.6 is released, we need to generate the import block because the
# resource ID to import needs to be a static string when Terraform runs
generate "import" {
  path      = "import.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    import {
      to = module.aws_account[0].aws_organizations_account.this
      id = 309961722645
    }
  EOF
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  organization = {
    aws_service_access_principals = [
      "access-analyzer.amazonaws.com",
      "cloudtrail.amazonaws.com",
      "config.amazonaws.com",
      "guardduty.amazonaws.com",
      "member.org.stacksets.cloudformation.amazonaws.com",
      "ram.amazonaws.com",
      "securityhub.amazonaws.com",
      "servicecatalog.amazonaws.com",
      "sso.amazonaws.com"
    ]
    enabled_policy_types = [
      "SERVICE_CONTROL_POLICY",
      "TAG_POLICY"
    ]

    organizational_units = {
      "Root" = {
        policies = [
          "restrict_runinstances_lambda_vpc",
          "scp_organizations_restrict"
        ]
        "Exceptions" = {
          "ExceptionAccounts" = {}
        }
        "Infrastructure" = {
          policies = [
            "scp_restrict_regions",
            "scp_security_services_baseline"
          ]
          "Backup" = {
            policies = [
              "scp_backup_account"
            ]
          }
          "NetworkProd" = {
            policies = [
              "scp_network_account"
            ]
          }
          "NetworkTest" = {
            policies = [
              "scp_network_account"
            ]
          }
          "SharedServicesProd" = {}
          "SharedServicesTest" = {}
        }
        "PolicyStaging" = {
          "Infrastructure" = {}
          "Sandbox"        = {}
          "Security"       = {}
          "Workload"       = {}
        }
        "Sandbox" = {
          "Demo" = {}
          "Dev"  = {}
        }
        "Security" = {
          policies = [
            "scp_restrict_regions",
            "scp_security_services_baseline"
          ]
          "Prod" = {}
          "Test" = {}
        }
        "Suspended" = {
          policies = [
            "scp_suspend_account"
          ]
        }
        "Workload" = {
          policies = [
            "scp_restrict_regions"
          ]
          "Prod" = {}
          "SDLC" = {}
        }
      }
    }
    policies = {
      "restrict_runinstances_lambda_vpc" = {
        description = "Do not let EC2 instances to be launched in the Lambda Shared VPC"
        content     = file("restrict_runinstances_lambda_vpc.json")
      }
      "scp_all_ou" = {
        description = "This SCP includes whitelisted regions, doesn't allow for disabling CloudTrail, Config or GuardDuty, leaving the Org,  Denying Root (not GovCloud) from performing actions and denies  anyone outside of SAMLAdminRole from creating IAM users or  Access Keys"
        content     = file("scp_all_ou.json")
      }
      "scp_backup_account" = {
        description = "This SCP blocks unnecessary services that are not used in the Backup accounts."
        content     = file("scp_backup_account.json")
      }
      "scp_logging_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Logging accounts"
        content     = file("scp_logging_account.json")
      }
      "scp_network_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Network accounts - needed services include Transit Gateways, VPN Tunnels, Palo Altos, Cisco SD-WAN, Direct Connect, Global Accelerator, NLB/ALB, CloudFront."
        content     = file("scp_network_account.json")
      }
      "scp_organizations_restrict" = {
        description = "This SCP does not allow an account to leave the Organization. Typical mapping is to the Root of the Organization."
        content     = file("scp_organizations_restrict.json")
      }
      "scp_restrict_instance_types" = {
        description = "This SCP blocks Xen EC2 instance types from being launched."
        content     = file("scp_restrict_instance_types.json")
      }
      "scp_restrict_regions" = {
        description = "This SCP blocks access to all regions other than us-east-1, us-east-2, us-west-2, eu-west-1, me-south-1, us-gov-west-1, us-gov-east-1 except for the actions listed in the NotAction block which indicate either Global services or specific services that would break automation. This SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("scp_restrict_regions.json")
      }
      "scp_security_services_baseline" = {
        description = "This SCP does not allow disabling CloudTrail, GuardDuty, Security Hub, Config, disable EBS Encryption by Default, delete Flow Logs, Delete an IAM Access Analyzer. This SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("scp_security_services_baseline.json")
      }
      "scp_suspend_account" = {
        description = "This SCP blocks all access other than to the Billing and Cost Explorer consoles."
        content     = file("scp_suspend_account.json")
      }
    }
  }

}
