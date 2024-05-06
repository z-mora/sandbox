load_balancers = {
  "alb-cometimpact-tls-dmz-prod" = {
    alb_drop_invalid_header_fields = false
    certificates = {
      "comet.parsons.com"  = {}
      "impact.parsons.com" = {}
    }
    deletion_protection     = true
    external_tls_decryption = true
    idle_timeout            = 360
    internal                = true
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "HTTPS"
        default_cert_key    = "comet.parsons.com"
        secondary_cert_keys = ["impact.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-80"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-013754a29e746c0ad", "subnet-0be672d2906ac9022"]
    target_groups = {
      "tg-port-80" = {
        port                            = 80
        protocol                        = "HTTP"
        targets                         = ["10.41.140.9"]
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/healthcheck.htm"
          port     = 80
          protocol = "HTTP"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-030b776ced499da52"
  }
}
