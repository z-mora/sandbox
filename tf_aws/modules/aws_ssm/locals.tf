locals {
  days = toset(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"])
  security_tools = {
    CrowdStrike-Install = {
      extra_variables = "role=security-tools install_crowdstrike=true"
      tag             = "CrowdStrike"
      tag_values      = ["true"]
    }
    CrowdStrike-Uninstall = {
      extra_variables = "role=security-tools uninstall_crowdstrike=true"
      tag             = "CrowdStrike"
      tag_values      = ["false"]
    }
    Splunk-Install = {
      extra_variables = "role=splunkforwarder install_splunkforwarder=true"
      tag             = "Splunk"
      tag_values      = ["true"]
    }
    Splunk-Uninstall = {
      extra_variables = "role=splunkforwarder uninstall_splunkforwarder=true"
      tag             = "Splunk"
      tag_values      = ["false"]
    }
    Tenable-Install = {
      extra_variables = "role=security-tools install_nessus=true"
      tag             = "Tenable"
      tag_values      = ["true"]
    }
    Tenable-Uninstall = {
      extra_variables = "role=security-tools uninstall_nessus=true"
      tag             = "Tenable"
      tag_values      = ["false"]
    }
  }
  stigs = {
    STIG-CAT1-Apply = {
      tag_values = ["cat1"]
    }
    STIG-CAT2-Apply = {
      tag_values = ["cat2"]
    }
    STIG-CAT3-Apply = {
      tag_values = ["cat3"]
    }
  }
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
}
