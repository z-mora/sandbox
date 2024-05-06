include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  organization = {
    aws_service_access_principals = [
      "access-analyzer.amazonaws.com",
      "account.amazonaws.com",
      "aws-artifact-account-sync.amazonaws.com",
      "backup.amazonaws.com",
      "cloudtrail.amazonaws.com",
      "compute-optimizer.amazonaws.com",
      "config-multiaccountsetup.amazonaws.com",
      "config.amazonaws.com",
      "fms.amazonaws.com",
      "guardduty.amazonaws.com",
      "member.org.stacksets.cloudformation.amazonaws.com",
      "ram.amazonaws.com",
      "reporting.trustedadvisor.amazonaws.com",
      "securityhub.amazonaws.com",
      "servicecatalog.amazonaws.com",
      "ssm.amazonaws.com",
      "sso.amazonaws.com",
      "tagpolicies.tag.amazonaws.com"
    ]
    enabled_policy_types = [
      "SERVICE_CONTROL_POLICY",
      "BACKUP_POLICY",
      "TAG_POLICY"
    ]

    organizational_units = {
      "Root" = {
        policies = [
          "organizations_restrict",
          "restrict_lambda_vpc_use"
        ]
        "Exceptions" = {
          "ExceptionAccounts" = {}
        }
        "Infrastructure" = {
          policies = [
            "restrict_regions",
            "restrict_root",
            "security_services_baseline"
          ]
          "Backup" = {
            "MEA" = {}
          }
          "NetworkProd" = {
            policies = [
              "network_account"
            ]
            "ca-central-1" = {}
            "MEA"          = {}
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
          "Infrastructure" = {
            policies = [
              "network_account"
            ]
          }
          "Sandbox" = {
            policies = [
              "restrict_regions",
              "restrict_root",
              "security_services_baseline"
            ]
          }
          "Security" = {
            policies = [
              "restrict_regions",
              "restrict_root",
              "security_services_baseline"
            ]
          }
          "Workload" = {
            policies = [
              "restrict_regions",
              "restrict_root",
              "security_services_baseline"
            ]
          }
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
            "restrict_root",
            "security_services_baseline"
          ]
          "Prod" = {
            "MEA" = {}
          }
          "Test" = {}
        }
        "ServiceCatalog" = {
          "Prod" = {}
          "Test" = {}
        }
        "Suspended" = {
        }
        "Workload" = {
          policies = [
            "restrict_regions",
            "restrict_root",
            "security_services_baseline"
          ]
          "Prod" = {
            "ca-central-1" = {}
            "MEA"          = {}
          }
          "SDLC" = {
            "MEA" = {}
          }
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
        description = "-"
        content     = file("organizations_restrict.json")
      }
      "restrict_lambda_vpc_use" = {
        description = "Do not let the use of Lambda Shared VPC unless by automation"
        content     = file("restrict_lambda_vpc_use.json")
      }
      "restrict_regions" = {
        description = "-"
        content     = file("restrict_regions.json")
      }
      "restrict_root" = {
        description = "-"
        content     = file("restrict_root.json")
      }
      "security_services_baseline" = {
        description = "-"
        content     = file("security_services_baseline.json")
      }
      "suspend_account" = {
        description = "This SCP blocks all access other than to the Billing and Cost Explorer consoles."
        content     = file("suspend_account.json")
      }
    }
  }
}
