locals {
  access_log_bucket      = "${local.access_log_bucket_name}-${var.region}"
  access_log_bucket_name = var.is_gov ? "parsons-gc-elb-aggregator" : "parsons-elb-aggregator"
  # Create a map of all domain validation records that need to be created
  all_certificate_validations = merge([
    for cert_key, cert in aws_acm_certificate.all : {
      for dvo in cert.domain_validation_options : dvo.domain_name => dvo
  }]...)
  # Create a map of all secondary listener certs. Key is a combo of listener key and cert key
  all_secondary_listener_certs = merge([
    for listener_key, listener in var.listeners : {
      for cert_key in listener.secondary_cert_keys :
      "${listener_key}-${cert_key}" => {
        cert_key     = cert_key
        listener_key = listener_key
      }
  }]...)
  # Create a map of all targets. Key is a combo of target group and target
  all_targets = merge([
    for target_group_key, target_group in var.target_groups : {
      for target in target_group.targets : "${target_group_key}-${target}" => {
        nlb_targets_outside_vpc = target_group.nlb_targets_outside_vpc
        target                  = target
        target_group_key        = target_group_key
        target_type             = target_group.type
      }
  }]...)
  has_tls_listener = anytrue([for l in var.listeners : l.protocol == "TLS"])
  internal_cidrs = toset([
    "10.0.0.0/8",
    "172.16.0.0/12",
    "169.254.0.0/16",
    "206.219.192.0/18"
  ])
  is_alb = var.type == "application" ? true : false
  is_nlb = var.type == "network" ? true : false
  listener_rules = merge([
    for listener_key, listener in var.listeners :
    { for rule_key, rule in listener.rules :
      "${listener_key}-${rule_key}" => merge({ "listener_key" = listener_key }, { "rule_key" = rule_key }, rule)
    }
  ]...)
  # Create a map containing the combinations of listeners and each internal CIDR. The
  # key is a combo of the listener and CIDR
  listeners_and_internal_cidrs = merge([
    for listener_key, listener in var.listeners :
    { for cidr in local.internal_cidrs :
      "${listener_key}-${cidr}" => {
        cidr = cidr
        port = listener.port
      }
    }
  ]...)
  target_group_for_port_80_listener = one([
    for tg_key, tg in var.target_groups :
    tg_key if tg.alb_target_for_port_80_listener
  ])
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
  parsons_domains = toset(flatten([for k, v in var.certificates : regex("(\\w+\\.\\w+){1}$", k)]))

}
