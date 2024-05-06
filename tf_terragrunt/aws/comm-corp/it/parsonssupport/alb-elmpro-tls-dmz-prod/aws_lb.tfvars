load_balancers = {
  "alb-elmpro-tls-dmz-prod" = {
    alb_drop_invalid_header_fields = false
    certificates = {
      "elm.parsons.com" = {}
    }
    deletion_protection     = true
    desync_mitigation_mode  = "monitor"
    external_tls_decryption = true
    idle_timeout            = 900
    internal                = true
    listeners = {
      "listener-80" = {
        port     = 80
        protocol = "HTTP"
        rules = {
          forward_lqe_path_to_lqe_tg = {
            priority = 10
            action = {
              type             = "forward"
              target_group_key = "tg-port-443-lqe"
            }
            conditions = {
              lqe = {
                path_pattern = ["/lqe*"]
              }
              from_internet_through_pa = {
                source_ip = ["169.254.0.0/16"] # Coming from the Internet through Palo Alto
              }
            }
          }
          forward_to_tg = {
            priority = 20
            action = {
              type             = "forward"
              target_group_key = "tg-port-443"
            }
            conditions = {
              from_internet_through_pa = {
                source_ip = ["169.254.0.0/16"] # Coming from the Internet through Palo Alto
              }
            }
          }
        }
        default_action = {
          type = "redirect"
          redirect = {
            host        = "#{host}"
            path        = "/#{path}"
            port        = 443
            protocol    = "HTTPS"
            query       = "#{query}"
            status_code = "HTTP_301"
          }
        }
      }
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        default_cert_key = "elm.parsons.com"
        rules = {
          forward_lqe_path_to_lqe_tg = {
            action = {
              type             = "forward"
              target_group_key = "tg-port-443-lqe"
            }
            conditions = {
              lqe = {
                path_pattern = ["/lqe*"]
              }
            }
          }
        }
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = false
    subnet_ids         = ["subnet-0ee5ec08b6c0a41d1", "subnet-01cdba01c51b4030b"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.41.129.98"] # Single Target does not need stickiness
        type                            = "ip"
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/jts/auth/authrequired"
          port     = 443
          protocol = "HTTPS"
        }
      }
      "tg-port-443-lqe" = {
        port     = 443
        protocol = "HTTPS"
        targets  = ["10.41.131.168"] # Single Target does not need stickiness
        type     = "ip"
        health_check = {
          path     = "/lqe/web/admin/config"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
