resource "null_resource" "account_variable_validation" {
  lifecycle {
    precondition {
      condition = (
        (var.account_details == null && var.account_id != null) ||
        (var.account_details != null && var.account_id == null)
      )
      error_message = "Must specify either account details or account ID, but not both"
    }
  }
}

resource "null_resource" "tgw_rt_variable_validation" {
  lifecycle {
    precondition {
      condition = (
        length(var.vpcs) > 0 && !local.is_corp_account ?
        length(var.tgw_route_tables) > 0 : true
      )
      error_message = <<-EOL
      If the current account is a non-corp account and you are creating a VPC, you
      must also create a TGW route table to establish connectivity and so the VPC is
      isolated. All BU VPCs are considered DMZs.
      EOL
    }
    precondition {
      condition = alltrue([
        for vpc_key, vpc in var.vpcs : (
          strcontains(vpc_key, "dmz") ? anytrue([
            for rt in var.tgw_route_tables : contains(rt.vpc_keys, vpc_key)
          ]) : true
        )
      ])
      error_message = "DMZ VPCs must have a TGW route table so they are isolated."
    }
  }
}

resource "null_resource" "org_master_account_validation" {
  lifecycle {
    precondition {
      condition = (
        (try(var.account_details.parent_ou_id, "") != null && var.organization == null) ||
        (try(var.account_details.parent_ou_id, null) == null && var.organization != null)
      )
      error_message = <<-EOL
      Must specify a parent ou if the account is not an org master account. 
      Otherwise the organization must be created as well.
      EOL
    }
  }
}
