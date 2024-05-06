load_balancers = {
  "alb-prjweb-tls-dmz-prod" = {
    certificates = {
      "pmhelp.parsons.com"          = {}
      "aimsbarcode.parsons.com"     = {}
      "cftwebapiext.parsons.com"    = {}
      "cftwebapiuatext.parsons.com" = {}
      "exiparsons.com" = {
        subject_alternative_names = ["www.exiparsons.com"]
      }
      "njinspections.com" = {
        subject_alternative_names = ["www.njinspections.com"]
      }
      "njinspection.com" = {
        subject_alternative_names = ["www.njinspection.com"]
      }
      "route45project.com" = {
        subject_alternative_names = ["www.route45project.com"]
      }
      "seaporte.parsons.com" = {}
      "project1.parsons.com" = {}
    }
    alb_drop_invalid_header_fields = true
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-80" = {
        port     = 80
        protocol = "HTTP"
        rules = {
          project1_host_header = {
            priority = 5
            action = {
              type = "redirect"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                host        = "app.industrysafe.com"
                path        = "/parsons"
              }
            }
            conditions = {
              project1_host_header_condition = {
                host_header = ["project1.parsons.com"]
              }
            }
          }
          njinspection_host_header = {
            priority = 10
            action = {
              type = "redirect"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                host        = "www.njinspections.com"
              }
            }
            conditions = {
              njinspection_host_header_condition = {
                host_header = ["njinspection.com", "www.njinspection.com", "njinspections.com"]
              }
            }
          }
          exiparsons_host_header = {
            priority = 15
            action = {
              type             = "redirect"
              target_group_key = "tg-port-443"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                path        = "/epm/weblogin.aspx"
              }
            }
            conditions = {
              exiparsons_host_header_condition = {
                host_header = ["www.exiparsons.com", "exiparsons.com"]
              }
              exiparsons_path_pattern_condition = {
                path_pattern = ["/"]
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
        port                = 443
        protocol            = "HTTPS"
        default_cert_key    = "pmhelp.parsons.com"
        secondary_cert_keys = ["exiparsons.com", "cftwebapiext.parsons.com", "cftwebapiuatext.parsons.com", "njinspections.com", "njinspection.com", "aimsbarcode.parsons.com", "route45project.com", "seaporte.parsons.com", "project1.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
        rules = {
          project1_host_header = {
            priority = 5
            action = {
              type = "redirect"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                host        = "app.industrysafe.com"
                path        = "/parsons"
              }
            }
            conditions = {
              project1_host_header_condition = {
                host_header = ["project1.parsons.com"]
              }
            }
          }
          exiparsons_host_header = {
            priority = 15
            action = {
              type             = "redirect"
              target_group_key = "tg-port-443"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                path        = "/epm/weblogin.aspx"
              }
            }
            conditions = {
              exiparsons_host_header_condition = {
                host_header = ["www.exiparsons.com", "exiparsons.com"]
              }
              exiparsons_path_pattern_condition = {
                path_pattern = ["/"]
              }
            }
          }
          njinspection_host_header = {
            priority = 10
            action = {
              type = "redirect"
              redirect = {
                port        = "443"
                protocol    = "HTTPS"
                status_code = "HTTP_301"
                host        = "www.njinspections.com"
              }
            }
            conditions = {
              njinspection_host_header_condition = {
                host_header = ["njinspection.com", "www.njinspection.com", "njinspections.com"]
              }
            }
          }
        }
      }
    }
    redirect_80_to_443 = false
    subnet_ids         = ["subnet-0ee5ec08b6c0a41d1", "subnet-01cdba01c51b4030b"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.41.128.88"] # Single Target does not need stickiness
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/healthcheck.htm"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
