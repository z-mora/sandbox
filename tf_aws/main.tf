module "aws_account" {
  count     = var.account_details == null ? 0 : 1
  providers = { aws = aws.management_account }
  source    = "./modules/aws_account"

  additional_alternate_contacts = var.account_details.additional_alternate_contacts
  additional_sso_assignments    = var.account_details.additional_sso_assignments
  admin_role_name               = var.account_details.admin_role_name
  common_alternate_contacts     = var.common_account_contacts
  common_sso_assignments        = var.common_account_sso_assignments
  create_govcloud               = var.account_details.create_govcloud
  email_address                 = var.account_details.email_address
  name                          = var.account_details.name
  organization_id               = data.aws_organizations_organization.current.id
  parent_ou_id                  = var.account_details.parent_ou_id
  tags                          = var.account_details.tags
}

module "aws_customer_gateway" {
  for_each  = var.customer_gateways
  providers = { aws = aws.current_account }
  source    = "./modules/aws_customer_gateway"

  bgp_asn    = each.value.bgp_asn
  name       = each.key
  ip_address = each.value.ip_address
  vpn_connections = {
    for key, value in each.value.vpn_connections :
    key => merge(value, { transit_gateway_id = module.aws_tgw[value.transit_gateway_key].id })
  }
}

module "aws_iam_group" {
  for_each  = var.iam_groups
  providers = { aws = aws.current_account }
  source    = "./modules/aws_iam_group"

  policies = {
    for key in each.value.policy_keys : key => module.aws_iam_policy[key].arn
  }
  name = each.key
}

module "aws_iam_policy" {
  for_each  = var.iam_policies
  providers = { aws = aws.current_account }
  source    = "./modules/aws_iam_policy"

  current_account_id = local.account_id
  current_partition  = data.aws_partition.current.partition
  current_region     = var.region
  description        = each.value.description
  name               = each.key
  name_prefix        = each.value.name_prefix
  path               = each.value.path
  policy_hcl         = each.value.policy_hcl
  policy_yaml        = each.value.policy_yaml
  tags               = each.value.tags
}

module "aws_iam_user" {
  for_each  = var.iam_users
  providers = { aws = aws.current_account }
  source    = "./modules/aws_iam_user"

  access_keys = each.value.access_keys
  groups = {
    for key in each.value.group_keys : key => module.aws_iam_group[key].name
  }
  name = each.key
  tags = each.value.tags
}

module "aws_lb" {
  for_each = var.load_balancers
  providers = {
    aws                 = aws.current_account
    aws.support_account = aws.support_account
  }
  source = "./modules/aws_lb"

  alb_drop_invalid_header_fields       = each.value.alb_drop_invalid_header_fields
  alb_fips                             = each.value.alb_fips
  certificates                         = each.value.certificates
  deletion_protection                  = each.value.deletion_protection
  deregistration_delay                 = each.value.deregistration_delay
  desync_mitigation_mode               = each.value.desync_mitigation_mode
  external_tls_decryption              = each.value.external_tls_decryption
  idle_timeout                         = each.value.idle_timeout
  internal                             = each.value.internal
  is_gov                               = local.is_gov
  listeners                            = each.value.listeners
  name                                 = each.key
  nlb_dns_record_client_routing_policy = each.value.nlb_dns_record_client_routing_policy
  nlb_network_cross_zone               = each.value.nlb_network_cross_zone
  redirect_80_to_443                   = each.value.redirect_80_to_443
  region                               = var.region
  subnet_ids = (
    each.value.subnet_ids != null ? each.value.subnet_ids :
    [for key in each.value.subnet_keys : module.aws_vpc[each.value.vpc_key].subnet_ids[key]]
  )
  tags          = each.value.tags
  target_groups = each.value.target_groups
  type          = each.value.type
  vpc_id = (
    each.value.vpc_id != null ? each.value.vpc_id :
    module.aws_vpc[each.value.vpc_key].id
  )
}

module "aws_organization" {
  count = var.organization != null ? 1 : 0
  providers = {
    aws = aws.current_account
  }
  source = "./modules/aws_organization"

  aws_service_access_principals = var.organization.aws_service_access_principals
  enabled_policy_types          = var.organization.enabled_policy_types
  feature_set                   = var.organization.feature_set
  policies                      = var.organization.policies
  tags                          = var.organization.tags
  organizational_units          = var.organization.organizational_units
}

module "aws_parsons_us_saml_idp" {
  count     = var.deploy_parsons_us_saml_idp == null ? 0 : 1
  providers = { aws = aws.current_account }
  source    = "./modules/aws_parsons_us_saml_idp"

  account_id = try(module.aws_account[0].id, var.account_id)
  account_name = try(
    module.aws_account[0].name, [
      for a in data.aws_organizations_organization.current.accounts :
      a.name if var.account_id == a.id
    ][0]
  )
  is_gov    = local.is_gov
  partition = data.aws_partition.current.partition
  roles     = var.deploy_parsons_us_saml_idp
}

module "aws_ssm" {
  count     = var.deploy_ssm ? 1 : 0
  providers = { aws = aws.current_account }
  source    = "./modules/aws_ssm"

  is_gov = local.is_gov
}

module "aws_tgw" {
  for_each  = var.transit_gateways
  providers = { aws = aws.current_account }
  source    = "./modules/aws_tgw"

  amazon_side_asn                 = each.value.amazon_side_asn
  auto_accept_shared_attachments  = each.value.auto_accept_shared_attachments
  cidr_blocks                     = each.value.cidr_blocks
  default_route_table_association = each.value.default_route_table_association
  default_route_table_propagation = each.value.default_route_table_propagation
  description                     = each.value.description
  dns_support                     = each.value.dns_support
  name                            = each.key
  share_to_principals             = each.value.share_to_principals
  tags                            = each.value.tags
  vpn_ecmp_support                = each.value.vpn_ecmp_support
}

module "aws_tgw_route_table" {
  for_each  = var.tgw_route_tables
  providers = { aws = aws.network_account }
  source    = "./modules/aws_tgw_route_table"

  name                     = each.key
  organization_id          = data.aws_organizations_organization.current.id
  override_blackhole_cidrs = each.value.override_blackhole_cidrs
  tags                     = each.value.tags
  tgw_vpc_attachment_ids = (
    length(each.value.vpc_keys) == 0 ? null :
    { for key in each.value.vpc_keys : key => module.aws_vpc[key].tgw_vpc_attachment_id }
  )
  transit_gateway_id = (
    each.value.transit_gateway_key == null ? null :
    { (each.value.transit_gateway_key) = module.aws_tgw[each.value.transit_gateway_key].id }
  )
}

module "aws_vpc" {
  for_each  = var.vpcs
  providers = { aws = aws.current_account }
  source    = "./modules/aws_vpc"

  cidr_block             = each.value.cidr_block
  dhcp_options           = each.value.dhcp_options
  enable_dns_hostnames   = each.value.enable_dns_hostnames
  enable_dns_support     = each.value.enable_dns_support
  flowlog_retention_days = each.value.flowlog_retention_days
  flowlog_traffic_type   = each.value.flowlog_traffic_type
  instance_tenancy       = each.value.instance_tenancy
  is_gov                 = local.is_gov
  private_subnets        = each.value.private_subnets
  region                 = var.region
  tags                   = each.value.tags
  transit_gateway_id     = each.value.transit_gateway_id
  vpc_name               = each.key
}
