# load_balancers = {
#   "test-internal-alb" = {
#     access_log_prefix = "test-internal-alb"
#     certificates = {
#       "test-internal-alb-1.parsons.com" = {
#         subject_alternative_names = ["www.test-internal-alb-1.parsons.com"]
#       }
#       # "test-internal-alb-2.parsons.com" = {}
#       # "test-internal-alb-3.parsons.com" = {
#       #   subject_alternative_names = ["www.test-internal-alb-3.parsons.com"]
#       # }
#     }
#     deletion_protection = false
#     alb_fips            = true
#     internal            = true
#     listeners = {
#       "listener-443" = {
#         port             = 443
#         protocol         = "HTTPS"
#         target_group_key = "tg-port-443"
#         default_cert_key = "test-internal-alb-1.parsons.com"
#         # secondary_cert_keys = ["test-internal-alb-2.parsons.com", "test-internal-alb-3.parsons.com"]
#       }
#     }
#     redirect_80_to_443       = true
#     subnet_ids               = ["subnet-0254fc850be603175", "subnet-0fd0449f8b696be22"]
#     target_group_name_prefix = "tg-test-internal-alb"
#     target_groups = {
#       "tg-port-443" = {
#         port                    = 443
#         protocol                = "HTTPS"
#         targets                 = ["192.168.12.190"]
#         type                    = "ip"
#         nlb_targets_outside_vpc = false
#         health_check = {
#           path     = "/"
#           port     = 443
#           protocol = "HTTPS"
#         }
#       }
#     }
#     type   = "application"
#     vpc_id = "vpc-073bd33d2cf3cc0b9"
#   }
#   "test-internal-nlb" = {
#     access_log_prefix = "test-internal-nlb"
#     certificates = {
#       "test-internal-nlb-1.parsons.com" = {
#         subject_alternative_names = ["www.test-internal-nlb-1.parsons.com"]
#       }
#     }
#     deletion_protection = false
#     internal            = true
#     listeners = {
#       "listener-443" = {
#         port             = 443
#         protocol         = "TLS"
#         target_group_key = "tg-nlb-port-443"
#         default_cert_key = "test-internal-nlb-1.parsons.com"
#       }
#     }
#     redirect_80_to_443       = true
#     subnet_keys              = ["PrivateSubnet1A", "PrivateSubnet2A"]
#     target_group_name_prefix = "tg-test-internal-nlb"
#     target_groups = {
#       "tg-nlb-port-443" = {
#         port               = 443
#         protocol           = "TLS"
#         targets            = ["192.168.12.190"]
#         type               = "ip"
#         # nlb_targets_outside_vpc = true
#         health_check = {
#           path     = "/"
#           port     = 443
#           protocol = "TCP"
#         }
#       }
#     }
#     type    = "network"
#     vpc_key = "vpc-dmz-parsons-com-sandbox-10-01"
#   }
# }
