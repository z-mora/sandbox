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
      id = 132340534103
    }
  EOF
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  organization = {
    aws_service_access_principals = [
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
      "SERVICE_CONTROL_POLICY"
    ]

    organizational_units = {
      "Root" = {
        policies = [
          "restrict_instance_types"
        ]
        "Exceptions" = {
          "ExceptionAccounts" = {}
        }
        "Infrastructure" = {
          policies = [
            "restrict_regions",
            "security_services_baseline"
          ]
          "Backup" = {
            policies = [
              "backup_account"
            ]
          }
          "NetworkProd" = {
            policies = [
              "network_account"
            ]
          }
          "NetworkTest" = {
            policies = [
              "network_account"
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
          policies = [
            "restrict_regions",
            "security_services_baseline"
          ]
          "Demo" = {}
          "Dev"  = {}
        }
        "Security" = {
          policies = [
            "restrict_regions",
            "security_services_baseline"
          ]
          "Prod" = {}
          "Test" = {}
        }
        "ServiceCatalog" = {
          "Prod" = {}
        }
        "Suspended" = {
          policies = [
            "suspended"
          ]
        }
        "Workload" = {
          policies = [
            "restrict_iam",
            "restrict_network",
            "restrict_regions",
            "security_services_baseline"
          ]
          "Prod" = {}
          "SDLC" = {}
        }
      }
    }
    policies = {
      "backup_account" = {
        description = "This SCP blocks unnecessary services that are not used in the Backup accounts."
        content     = file("backup_account.json")
      }
      "logging_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Logging accounts"
        content     = file("logging_account.json")
      }
      "network_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Network accounts - needed services include Transit Gateways, VPN Tunnels, Palo Altos, Cisco SD-WAN, Direct Connect, Global Accelerator, NLB/ALB, CloudFront."
        content     = file("network_account.json")
      }
      "organizations_restrict" = {
        description = "This SCP does not allow an account to leave the Organization.\nTypical mapping is to the Root of the Organization."
        content     = file("organizations_restrict.json")
      }
      "restrict_iam" = {
        description = "Restrict the modification of any SC-*  or StackSet-* CloudFormation stacks, restrict the modification of the password policy, creation of IAM user passwords, SAML or OpenID identity providers, modification of specific Roles and Policies unless by specific roles."
        content     = file("restrict_iam.json")
      }
      "restrict_instance_types" = {
        description = "This SCP blocks Xen EC2 instance types from being launched."
        content     = file("restrict_instance_types.json")
      }
      "restrict_network" = {
        description = "Restrict Workload accounts from creating VPCs, subnets, route changes, TGWs, VGWs."
        content     = file("restrict_network.json")
      }
      "restrict_regions" = {
        description = "This SCP blocks access to all regions other than us-east-1, us-east-2, us-west-2, eu-west-1, me-south-1, us-gov-west-1, us-gov-east-1 except for the actions listed in the NotAction block which indicate either Global services or specific services that would break automation.\n\nThis SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("restrict_regions.json")
      }
      "security_services_baseline" = {
        description = "This SCP does not allow disabling CloudTrail, GuardDuty, Security Hub, Config, disable EBS Encryption by Default, delete Flow Logs, Delete an IAM Access Analyzer.\n\nThis SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("security_services_baseline.json")
      }
      "suspended" = {
        description = "Accounts that are no longer in use or set for termination."
        content     = file("suspended.json")
      }
    }
  }

}
