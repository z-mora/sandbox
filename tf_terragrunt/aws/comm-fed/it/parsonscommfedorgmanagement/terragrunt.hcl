include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  organization = {
    aws_service_access_principals = [
      "account.amazonaws.com",
      "cloudtrail.amazonaws.com",
      "compute-optimizer.amazonaws.com",
      "config.amazonaws.com",
      "guardduty.amazonaws.com",
      "member.org.stacksets.cloudformation.amazonaws.com",
      "ram.amazonaws.com",
      "servicecatalog.amazonaws.com",
      "sso.amazonaws.com"
    ]
    enabled_policy_types = [
      "SERVICE_CONTROL_POLICY"
    ]

    organizational_units = {
      "Root" = {
        policies = [
          "organization_restrict"
        ]
        "Exceptions" = {
          "ExceptionAccounts" = {}
        },
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
          "NetworkProd"        = {}
          "NetworkTest"        = {}
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
            "restrict_root",
            "security_services_baseline"
          ]
          "Demo" = {}
          "Dev"  = {}
        }
        "Security" = {
          policies = [
            "restrict_regions",
            "restrict_root"
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
        description = "This SCP blocks unnecessary services that are not used in the Backup accounts.\n\nThis SCP maps to the Backup OU."
        content     = file("backup_account.json")
      }
      "logging_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Logging accounts.\n\nThis SCP maps to the Logging account."
        content     = file("logging_account.json")
      }
      "network_account" = {
        description = "This SCP blocks unnecessary services that are not used in the centralized Network accounts - needed services include Transit Gateways, VPN Tunnels, Palo Altos, Cisco SD-WAN, Direct Connect, Global Accelerator, NLB/ALB, CloudFront.\n\nThis SCP maps to the Network OUs."
        content     = file("network_account.json")
      }
      "organization_restrict" = {
        description = "This SCP does not allow an account to leave the Organization.\n\nTypical mapping is to the Root of the Organization."
        content     = file("organization_restrict.json")
      }
      "restrict_iam" = {
        description = "Restrict the modification of any SC-* or StackSet-* CloudFormation stacks, restrict the modification of the password policy, creation of IAM user passwords, SAML or OpenID identity providers, modification of specific Roles and Policies unless by specific roles."
        content     = file("restrict_iam.json")
      }
      "restrict_network" = {
        description = "Restrict Workload accounts from creating VPCs, subnets, route changes, TGWs, VGWs."
        content     = file("restrict_network.json")
      }
      "restrict_regions" = {
        description = "This SCP blocks access to all regions other than us-east-1, us-east-2, us-west-2, eu-west-1, me-south-1, us-gov-west-1, us-gov-east-1 except for the actions listed in the NotAction block which indicate either Global services or specific services that would break automation.\n\nThis SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("restrict_regions.json")
      }
      "restrict_root" = {
        description = "This SCP does not allow root to perform administrative tasks at an account level, unless it is a Root only action such as changing the account name, changing AWS support plans, creating DNS PTR reverse records, managing Root credentials etc. https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html#not-restricted-by-scp\n\nThis SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("restrict_root.json")
      }
      "security_services_baseline" = {
        description = "This SCP does not allow disabling CloudTrail, GuardDuty, Security Hub, Config, Delete an IAM Access Analyzer.\n\nThis SCP maps to the Main OUs under Root - Security, Infrastructure, Workloads, Sandbox."
        content     = file("security_services_baseline.json")
      }
      "suspended" = {
        description = "This SCP blocks all access other than to the Billing and Cost Explorer consoles.\n\nThis SCP maps to the Suspended OU."
        content     = file("suspended.json")
      }
      "temp_block_default_vpc_dex" = {
        description = "Delete default vpcs lambda didn't function correctly"
        content     = file("temp_block_default_vpc_dex.json")
      }
    }
  }

}
