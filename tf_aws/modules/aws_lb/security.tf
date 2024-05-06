resource "aws_security_group" "alb" {
  count = local.is_alb || var.redirect_80_to_443 ? 1 : 0

  description = "Access to ${var.name}"
  name        = "SG-${var.name}"
  tags        = local.tags
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_from_internet" {
  count = var.redirect_80_to_443 && var.internal == false ? 1 : 0

  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.alb[0].id
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_from_internal" {
  for_each = var.redirect_80_to_443 && var.internal ? local.internal_cidrs : toset([])

  cidr_ipv4         = each.key
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.alb[0].id
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "listener_ports_internet" {
  for_each = local.is_alb && var.internal == false ? var.listeners : {}

  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value.port
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.alb[0].id
  to_port           = each.value.port
}

resource "aws_vpc_security_group_ingress_rule" "listener_ports_internal" {
  for_each = local.is_alb && var.internal ? local.listeners_and_internal_cidrs : {}

  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.alb[0].id
  to_port           = each.value.port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_internal" {
  count = local.is_alb && var.internal ? 1 : 0

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "all"
  security_group_id = aws_security_group.alb[0].id
}
