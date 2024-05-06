data "aws_route53_zone" "parsons_domain" {
  for_each = local.parsons_domains
  provider = aws.support_account

  name         = each.value
  private_zone = false
}

resource "aws_route53_record" "validation" {
  for_each = local.all_certificate_validations
  provider = aws.support_account

  allow_overwrite = true
  name            = each.value.resource_record_name
  records         = [each.value.resource_record_value]
  ttl             = 3600
  type            = each.value.resource_record_type
  zone_id         = data.aws_route53_zone.parsons_domain[regex("(\\w+\\.\\w+){1}$", each.value.domain_name)[0]].zone_id
}

resource "aws_acm_certificate_validation" "all" {
  for_each = aws_acm_certificate.all

  certificate_arn = each.value.arn
  validation_record_fqdns = [
    for dvo in each.value.domain_validation_options :
    aws_route53_record.validation[dvo.domain_name].fqdn
  ]
}
