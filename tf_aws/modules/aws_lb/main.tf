resource "aws_lb" "main" {
  desync_mitigation_mode = local.is_alb ? var.desync_mitigation_mode : null
  dns_record_client_routing_policy = (
    local.is_nlb && !var.is_gov ? var.nlb_dns_record_client_routing_policy : null
  )
  drop_invalid_header_fields       = local.is_alb ? var.alb_drop_invalid_header_fields : false
  enable_cross_zone_load_balancing = var.nlb_network_cross_zone
  enable_deletion_protection       = var.deletion_protection
  enable_http2                     = local.is_alb ? true : false
  idle_timeout                     = local.is_alb ? var.idle_timeout : null
  internal                         = var.internal
  load_balancer_type               = var.type
  name                             = var.name
  security_groups                  = local.is_alb ? [aws_security_group.alb[0].id] : null
  subnets                          = var.subnet_ids
  tags                             = merge(local.tags, var.alb_fips ? { alb-fips-enabled = "" } : {})

  access_logs {
    bucket  = local.access_log_bucket
    enabled = local.is_alb || local.has_tls_listener ? true : false
    prefix  = var.name
  }

  lifecycle {
    precondition {
      condition     = var.alb_fips ? local.is_alb : true
      error_message = "alb_fips is only to be used with ALBs"
    }
    precondition {
      condition     = var.nlb_network_cross_zone ? local.is_nlb : true
      error_message = "nlb_network_cross_zone is only to be used with NLBs"
    }
  }
}

resource "aws_lb" "alb_redirect_80_to_443_for_nlb" {
  count = local.is_nlb && var.redirect_80_to_443 ? 1 : 0

  drop_invalid_header_fields = true
  enable_deletion_protection = var.deletion_protection
  enable_http2               = true
  internal                   = var.internal
  load_balancer_type         = "application"
  name                       = replace(var.name, "nlb", "alb")
  security_groups            = [aws_security_group.alb[0].id]
  subnets                    = var.subnet_ids
  tags                       = local.tags

  access_logs {
    bucket  = local.access_log_bucket
    enabled = true
    prefix  = replace(var.name, "nlb", "alb")
  }
}

resource "aws_lb_listener" "main" {
  for_each = var.listeners

  certificate_arn = (
    each.value.protocol == "HTTPS" || each.value.protocol == "TLS" ?
    aws_acm_certificate.all[each.value.default_cert_key].arn : null
  )
  load_balancer_arn = aws_lb.main.arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy = (
    each.value.protocol == "HTTPS" || each.value.protocol == "TLS" ?
    "ELBSecurityPolicy-TLS-1-2-2017-01" : null
  )
  tags = local.tags

  default_action {

    type             = each.value.default_action.type
    target_group_arn = each.value.default_action.target_group_key != null ? aws_lb_target_group.main[each.value.default_action.target_group_key].arn : null

    dynamic "fixed_response" {
      for_each = each.value.default_action.fixed_response == null ? {} : { key = each.value.default_action.fixed_response }

      content {
        content_type = fixed_response.value["content_type"]
        message_body = fixed_response.value["message_body"]
        status_code  = fixed_response.value["status_code"]
      }
    }

    dynamic "forward" {
      for_each = each.value.default_action.forward == null ? {} : { key = each.value.default_action.forward }

      content {
        dynamic "target_group" {
          for_each = forward.value["target_groups"]

          content {
            arn    = aws_lb_target_group.main[target_group.value["key"]].arn
            weight = target_group.value["weight"]
          }
        }

        dynamic "stickiness" {
          for_each = forward.value["stickiness"] == null ? {} : { key = forward.value["stickiness"] }

          content {
            enabled  = stickiness.value["enabled"]
            duration = stickiness.value["duration"]
          }
        }
      }
    }

    dynamic "redirect" {
      for_each = each.value.default_action.redirect == null ? {} : { key = each.value.default_action.redirect }

      content {
        host        = redirect.value["host"]
        path        = redirect.value["path"]
        port        = redirect.value["port"]
        protocol    = redirect.value["protocol"]
        query       = redirect.value["query"]
        status_code = redirect.value["status_code"]
      }
    }
  }

  lifecycle {
    precondition {
      condition = (each.value.default_cert_key != null ?
      each.value.protocol == "HTTPS" || each.value.protocol == "TLS" : true)
      error_message = "Only specify a cert if the listener is using HTTPS or TLS"
    }
    precondition {
      condition = (each.value.default_cert_key == null ?
      each.value.protocol != "HTTPS" && each.value.protocol != "TLS" : true)
      error_message = "Cert is required for the listener if using HTTPS or TLS"
    }
  }

  depends_on = [aws_acm_certificate_validation.all]
}

resource "aws_lb_listener_rule" "this" {
  for_each = local.listener_rules

  listener_arn = aws_lb_listener.main[each.value.listener_key].arn
  priority     = each.value.priority
  tags         = merge(local.tags, { Name = each.value.rule_key })

  action {
    type             = each.value.action.type
    target_group_arn = try(aws_lb_target_group.main[each.value.action.target_group_key].arn, null)

    dynamic "fixed_response" {
      for_each = each.value.action.fixed_response == null ? {} : { key = each.value.action.fixed_response }

      content {
        content_type = fixed_response.value["content_type"]
        message_body = fixed_response.value["message_body"]
        status_code  = fixed_response.value["status_code"]
      }
    }

    dynamic "forward" {
      for_each = each.value.action.forward == null ? {} : { key = each.value.action.forward }

      content {
        dynamic "target_group" {
          for_each = forward.value["target_groups"]

          content {
            arn    = aws_lb_target_group.main[target_group.value["key"]].arn
            weight = target_group.value["weight"]
          }
        }

        dynamic "stickiness" {
          for_each = forward.value["stickiness"] == null ? {} : { key = forward.value["stickiness"] }

          content {
            enabled  = stickiness.value["enabled"]
            duration = stickiness.value["duration"]
          }
        }
      }
    }

    dynamic "redirect" {
      for_each = each.value.action.redirect == null ? {} : { key = each.value.action.redirect }

      content {
        host        = redirect.value["host"]
        path        = redirect.value["path"]
        port        = redirect.value["port"]
        protocol    = redirect.value["protocol"]
        query       = redirect.value["query"]
        status_code = redirect.value["status_code"]
      }
    }
  }

  dynamic "condition" {
    for_each = each.value.conditions

    content {
      dynamic "host_header" {
        for_each = condition.value["host_header"] == null ? {} : { key = condition.value["host_header"] }
        content {
          values = host_header.value
        }
      }

      dynamic "http_request_method" {
        for_each = condition.value["http_request_method"] == null ? {} : { key = condition.value["http_request_method"] }
        content {
          values = http_request_method.value
        }
      }

      dynamic "path_pattern" {
        for_each = condition.value["path_pattern"] == null ? {} : { key = condition.value["path_pattern"] }
        content {
          values = path_pattern.value
        }
      }

      dynamic "source_ip" {
        for_each = condition.value["source_ip"] == null ? {} : { key = condition.value["source_ip"] }
        content {
          values = source_ip.value
        }
      }

      dynamic "http_header" {
        for_each = condition.value["http_header"] == null ? {} : { key = condition.value["http_header"] }
        content {
          http_header_name = http_header.value["http_header_name"]
          values           = http_header.value["values"]
        }
      }

      dynamic "query_string" {
        for_each = condition.value["query_string"]
        content {
          key   = query_string.value["key"]
          value = query_string.value["value"]
        }
      }
    }
  }
}

resource "aws_lb_listener" "redirect_80_to_443" {
  count = var.redirect_80_to_443 ? 1 : 0

  load_balancer_arn = local.is_alb ? aws_lb.main.arn : aws_lb.alb_redirect_80_to_443_for_nlb[0].arn
  port              = 80
  protocol          = "HTTP"
  tags              = local.tags

  default_action {
    type = "redirect"
    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = 443
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "forward_80_to_alb" {
  count = local.is_nlb && var.redirect_80_to_443 ? 1 : 0

  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "TCP"
  tags              = local.tags

  default_action {
    target_group_arn = aws_lb_target_group.alb_redirect_80_to_443_for_nlb[0].arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "external_tls_decryption" {
  count = (
    var.redirect_80_to_443 &&
    var.external_tls_decryption &&
    local.target_group_for_port_80_listener != null ? 1 : 0
  )

  listener_arn = aws_lb_listener.redirect_80_to_443[0].arn
  tags         = merge(local.tags, { Name = "forward_to_tg_from_pa" })

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[local.target_group_for_port_80_listener].arn
  }

  condition {
    source_ip {
      values = ["169.254.0.0/16"] # Coming from the Internet through Palo Alto
    }
  }
}

resource "aws_lb_target_group" "main" {
  for_each = var.target_groups

  connection_termination = local.is_nlb ? each.value.nlb_connection_termination : null
  deregistration_delay   = var.deregistration_delay
  port                   = each.value.port
  preserve_client_ip     = each.value.nlb_preserve_client_ip
  protocol               = each.value.protocol
  tags                   = local.tags
  target_type            = each.value.type
  vpc_id                 = var.vpc_id

  health_check {
    enabled  = true
    matcher  = local.is_alb ? each.value.health_check.matcher : null
    port     = each.value.health_check.port
    protocol = each.value.health_check.protocol
    path     = each.value.health_check.path
  }

  # Don't use a dynamic block for stickiness - if no stickiness block is provided it
  # will enable stickiness by default
  stickiness {
    cookie_duration = try(each.value.stickiness.cookie_duration, null)
    cookie_name     = try(each.value.stickiness.cookie_name, null)
    enabled         = try(each.value.stickiness.enabled, false)
    type            = try(each.value.stickiness.type, local.is_alb ? "lb_cookie" : "source_ip")
  }

  lifecycle {
    create_before_destroy = true
    precondition {
      condition     = each.value.nlb_connection_termination ? local.is_nlb : true
      error_message = "Only enable nlb_connection_termination if deploying a NLB"
    }
    precondition {
      condition     = each.value.nlb_preserve_client_ip != null ? local.is_nlb : true
      error_message = "Only set nlb_preserve_client_ip if deploying a NLB"
    }
    precondition {
      condition     = each.value.protocol == "TLS" && try(each.value.stickiness.enabled, false) ? false : true
      error_message = "You cannot enable stickiness on target groups with the TLS protocol"
    }
    precondition {
      condition = (
        (local.is_nlb && try(each.value.stickiness.type, false) == "source_ip") ||
        (local.is_alb && (
          try(each.value.stickiness.type == "app_cookie", false) || try(each.value.stickiness.type == "lb_cookie", false)
          )
        ) ||
        (each.value.stickiness == null)
      )
      error_message = "Stickiness type on ALB must be lb_cookie or app_cookie, and on NLB must be source_ip"
    }
  }
}

resource "aws_lb_target_group" "alb_redirect_80_to_443_for_nlb" {
  count = local.is_nlb && var.redirect_80_to_443 ? 1 : 0

  deregistration_delay = var.deregistration_delay
  port                 = 80
  protocol             = "TCP"
  tags                 = local.tags
  target_type          = "alb"
  vpc_id               = var.vpc_id

  depends_on = [aws_lb_listener.redirect_80_to_443]
}

resource "aws_lb_target_group_attachment" "main" {
  for_each = local.all_targets

  availability_zone = each.value.nlb_targets_outside_vpc ? "all" : null
  port              = aws_lb_target_group.main[each.value.target_group_key].port
  target_group_arn  = aws_lb_target_group.main[each.value.target_group_key].arn
  target_id         = each.value.target

  lifecycle {
    precondition {
      condition = (each.value.nlb_targets_outside_vpc ?
      local.is_nlb && each.value.target_type == "ip" : true)
      error_message = "Only use nlb_targets_outside_vpc when creating a NLB IP target group"
    }
  }
}

resource "aws_lb_target_group_attachment" "alb_redirect_80_to_443_for_nlb" {
  count = local.is_nlb && var.redirect_80_to_443 ? 1 : 0

  port             = 80
  target_group_arn = aws_lb_target_group.alb_redirect_80_to_443_for_nlb[0].arn
  target_id        = aws_lb.alb_redirect_80_to_443_for_nlb[0].arn
}

resource "aws_acm_certificate" "all" {
  for_each = var.certificates

  domain_name               = each.key
  subject_alternative_names = each.value.subject_alternative_names
  tags                      = local.tags
  validation_method         = "DNS"
}

resource "aws_lb_listener_certificate" "secondary" {
  for_each = local.all_secondary_listener_certs

  certificate_arn = aws_acm_certificate.all[each.value.cert_key].arn
  listener_arn    = aws_lb_listener.main[each.value.listener_key].arn

  depends_on = [aws_acm_certificate_validation.all]
}
