load_balancers = {
  "alb-pwebtoolscrt-int-qa" = {
    certificates = {
      "pwebtoolscrt2012.parsons.com" = {}
      "webtimecrt2012.parsons.com"   = {}
    }
    deletion_protection            = false
    alb_drop_invalid_header_fields = false
    external_tls_decryption        = false
    alb_fips                       = false
    internal                       = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        target_group_key = "tg-port-443"
        default_cert_key = "pwebtoolscrt2012.parsons.com"
        secondary_cert_keys = [
          "webtimecrt2012.parsons.com"
        ]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-f6d539bf", "subnet-2a685772"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.41.4.56", "10.41.5.60"]
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/"
          port     = 443
          protocol = "HTTPS"
        }
        stickiness = {
          type = "lb_cookie"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-ce70e9a9"
  }
}
