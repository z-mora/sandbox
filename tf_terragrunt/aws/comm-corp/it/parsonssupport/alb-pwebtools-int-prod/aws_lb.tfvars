load_balancers = {
  "alb-pwebtools-int-prod" = {
    certificates = {
      "pwebtools.parsons.com" = {}
      "webtime.parsons.com"   = {}
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
        default_cert_key = "pwebtools.parsons.com"
        secondary_cert_keys = [
          "webtime.parsons.com"
        ]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-9483babc", "subnet-9623dce1"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.45.2.170", "10.45.3.112", "10.45.2.144", "10.45.3.220"]
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
    vpc_id = "vpc-59e9373c"
  }
}
