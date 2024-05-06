output "account_id" {
  value       = try(module.aws_account[0].id, null)
  description = "The ID of the AWS account being managed"
}

output "current_partition" {
  value       = data.aws_partition.current.partition
  description = "The current AWS partition"
}

output "current_region" {
  value       = var.region
  description = "The current AWS region"
}

output "customer_gateways" {
  value       = length(module.aws_customer_gateway) > 0 ? module.aws_customer_gateway : null
  description = "A map of all customer gatweays and their outputs"
}

output "govcloud_account_id" {
  value       = try(module.aws_account[0].govcloud_account_id, null)
  description = "The ID of the AWS GovCloud account that was created"
}

output "iam_groups" {
  value       = length(module.aws_iam_group) > 0 ? module.aws_iam_group : null
  description = "A map of all IAM groups and their outputs"
}

output "iam_policies" {
  value       = length(module.aws_iam_policy) > 0 ? module.aws_iam_policy : null
  description = "A map of all IAM policies and their outputs"
}

output "iam_user_access_keys" {
  value = length(
    flatten([for u in module.aws_iam_user : [for k, v in u.access_keys : k]])
    ) > 0 ? {
    for user_key, user in module.aws_iam_user :
    user_key => user.access_keys if length(user.access_keys) > 0
  } : null
  sensitive   = true
  description = "A map of each IAM user and its access keys"
}

output "iam_users" {
  value = length(module.aws_iam_user) > 0 ? {
    for user_key, user in module.aws_iam_user : user_key => {
      for k, v in user : k => v if k != "access_keys"
    }
  } : null
  description = "A map of all IAM users and their outputs"
}

output "load_balancers" {
  value       = length(module.aws_lb) > 0 ? module.aws_lb : null
  description = "A map of all load balancers and their outputs"
}

output "parsons_us_saml_okta_group_names" {
  value       = try(module.aws_parsons_us_saml_idp[0].okta_group_names, null)
  description = "What the name(s) of the Okta group(s) should be for parsons.us SAML setup"
}

output "transit_gateway_route_tables" {
  value       = length(module.aws_tgw_route_table) > 0 ? module.aws_tgw_route_table : null
  description = "A map of all transit gateway route tables and their outputs"
}

output "transit_gateways" {
  value       = length(module.aws_tgw) > 0 ? module.aws_tgw : null
  description = "A map of all transit gateways and their outputs"
}

output "vpcs" {
  value       = length(module.aws_vpc) > 0 ? module.aws_vpc : null
  description = "A map of all VPCs and their outputs"
}
