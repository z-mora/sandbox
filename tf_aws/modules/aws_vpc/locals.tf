locals {
  comm_log_aggregator = "arn:aws:logs:${var.region}:307693111226:destination:parsons-vpc-flowlogs-aggregator-destination"
  gov_log_aggregator  = "arn:aws-us-gov:logs:${var.region}:760713121800:destination:parsonsgc-vpc-flowlogs-aggregator-destination"
  log_aggregator_destination = (var.is_gov ?
    local.gov_log_aggregator : local.comm_log_aggregator
  )
  private_subnet_id_per_az = [for k in local.subnet_per_az : aws_subnet.private[k].id]
  subnet_per_az = values(zipmap(
    [for k, v in var.private_subnets : v.availability_zone],
    [for k, v in var.private_subnets : k]
  ))
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
}
