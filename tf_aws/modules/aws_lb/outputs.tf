output "arn" {
  value       = aws_lb.main.arn
  description = "Load balancer ARN"
}

output "dns_name" {
  value       = aws_lb.main.dns_name
  description = "Load balancer DNS name"
}

output "secondary_lb_for_redirect" {
  value = length(aws_lb.alb_redirect_80_to_443_for_nlb) == 0 ? null : {
    arn             = aws_lb.alb_redirect_80_to_443_for_nlb[0].arn
    dns_name        = aws_lb.alb_redirect_80_to_443_for_nlb[0].dns_name
    security_groups = aws_lb.alb_redirect_80_to_443_for_nlb[0].security_groups
    type            = aws_lb.alb_redirect_80_to_443_for_nlb[0].load_balancer_type
  }
  description = "Seconday ALB details. Created as part of a NLB deployment for port 80 redirect."
}

output "security_groups" {
  value       = aws_lb.main.security_groups
  description = "Load balancer security group(s)"
}

output "target_group_arns" {
  value       = { for tg_key, tg in aws_lb_target_group.main : tg_key => tg.arn }
  description = "Load balancer target group ARNs"
}

output "type" {
  value       = aws_lb.main.load_balancer_type
  description = "Load balancer type"
}
