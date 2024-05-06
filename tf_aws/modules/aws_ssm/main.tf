resource "aws_ssm_association" "security_tool" {
  for_each = local.security_tools

  association_name    = each.key
  compliance_severity = "HIGH"
  name                = aws_ssm_document.apply_ansible_playbooks.name
  schedule_expression = "rate(30 minutes)"

  parameters = {
    Check               = "False"
    ExtraVariables      = each.value.extra_variables
    InstallDependencies = "False"
    PlaybookFile        = "ansible/ssm-run-role.yml"
    SourceInfo = (var.is_gov ?
      "{\"path\":\"https://par-ssm-automation-files-us-gov-east-1.s3.us-gov-east-1.amazonaws.com/\"}" :
      "{\"path\":\"https://par-ssm-automation-files-us-east-1.s3.us-east-1.amazonaws.com/\"}"
    )
    SourceType     = "S3"
    TimeoutSeconds = 3600
    Verbose        = "-v"
  }

  targets {
    key    = "tag:${each.value.tag}"
    values = each.value.tag_values
  }
}

resource "aws_ssm_association" "software_inventory" {
  association_name    = "SoftwareInventory"
  name                = "AWS-GatherSoftwareInventory"
  schedule_expression = "rate(1 day)"

  parameters = {
    applications                = "Enabled"
    awsComponents               = "Enabled"
    instanceDetailedInformation = "Enabled"
    networkConfig               = "Enabled"
    services                    = "Enabled"
    windowsRoles                = "Disabled"
    windowsUpdates              = "Enabled"
  }

  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
}

resource "aws_ssm_association" "stig" {
  for_each = local.stigs

  association_name    = each.key
  compliance_severity = "HIGH"
  name                = "AWSEC2-ConfigureSTIG"

  parameters = {
    Level = "Low"
  }

  targets {
    key    = "tag:STIG"
    values = each.value.tag_values
  }
}

resource "aws_ssm_resource_data_sync" "inventory_to_s3" {
  name = "ssm-resource-data-sync"

  s3_destination {
    bucket_name = (var.is_gov ? "par-ssm-maintenance-logs-us-gov-east-1" :
      "par-ssm-maintenance-logs-us-east-1"
    )
    region = var.is_gov ? "us-gov-east-1" : "us-east-1"
  }
}
