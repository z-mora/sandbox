variable "account_details" {
  type = object({
    additional_alternate_contacts = optional(map(object({
      alternate_contact_type = string
      title                  = string
      email_address          = string
      phone_number           = string
    })), {})
    additional_sso_assignments = optional(map(object({
      instance_arn       = string
      target_type        = string
      permission_set_arn = string
      principal_type     = string
      principal_id       = string
    })), {})
    admin_role_name = optional(string, "OrganizationAccountAccessRole")
    # Only use on a Commercial account to create a linked GovCloud account
    # Cannot be changed after initial creation
    create_govcloud = optional(bool, false)
    email_address   = string
    name            = string
    parent_ou_id    = optional(string)
    # These optional tags will override provider defaults
    tags = optional(map(string), {})
  })
  default     = null
  description = "Details of the account to create"
}

variable "account_id" {
  type        = string
  default     = null
  description = "Account ID of an existing account to create resources in"
}

variable "common_account_contacts" {
  type = map(object({
    alternate_contact_type = string
    title                  = string
    email_address          = string
    phone_number           = string
  }))
  description = "Map of objects for common account alternate contacts"
  default     = {}
}

variable "common_account_sso_assignments" {
  type = map(object({
    instance_arn       = string
    target_type        = string
    permission_set_arn = string
    principal_type     = string
    principal_id       = string
  }))
  description = "Map of objects for common account SSO assignments"
  default     = {}
}

variable "customer_gateways" {
  type = map(object({
    bgp_asn    = number
    ip_address = string
    tags       = optional(map(string), {})
    vpn_connections = map(object({
      transit_gateway_key = string
    }))
  }))
  description = "value"
  default     = {}
}

variable "default_tags" {
  type = object({
    App         = string
    Environment = string
    GBU         = string
    JobWbs      = string
    Notes       = optional(string)
    Owner       = string
  })
  description = "Required default AWS tags"

  validation {
    condition     = contains(["DEV", "DR", "PROD", "QA", "TEST"], var.default_tags.Environment)
    error_message = "Environment tag must be one of: DEV, TEST, QA, PROD, DR"
  }

  validation {
    condition     = contains(["COR", "FED", "INF", "MEA"], var.default_tags.GBU)
    error_message = "GBU tag must be one of: COR, FED, INF, MEA"
  }

  validation {
    condition     = can(regex("^\\d{6}-\\d{5}$", var.default_tags.JobWbs))
    error_message = "JobWbs tag must be digits in the format xxxxxx-xxxxx"
  }

  validation {
    condition     = can(regex("(?i)[A-Z0-9+_.-]+@[A-Z0-9.-]+", var.default_tags.Owner))
    error_message = "Owner tag must be a valid email address"
  }
}

variable "deploy_parsons_us_saml_idp" {
  default     = null
  description = <<-EOL
  If a SAML IdP should be deployed for parsons.us users to access the account, set this
  value to a set of strings to define which roles should be configured. See the module
  for more info about what roles are supported.
  EOL
  type        = set(string)
}

variable "deploy_ssm" {
  type        = bool
  description = "Whether to deploy SSM managed support in the account."
  default     = false
}

variable "iam_groups" {
  type = map(object({
    path        = optional(string, "/")
    policy_keys = set(string)
  }))
  default     = {}
  description = "A collection of IAM groups to create"
}

variable "iam_policies" {
  type = map(object({
    description = optional(string)
    name_prefix = optional(string)
    path        = optional(string, "/")
    policy_hcl = optional(object({
      statements = map(object({
        actions   = optional(list(string))
        effect    = string
        resources = list(string)
        sid       = optional(string)
      }))
      version = optional(string, "2012-10-17")
    }))
    policy_yaml = optional(string)
    tags        = optional(map(string))
  }))
  default     = {}
  description = "A collection of IAM policies to create"

  validation {
    condition = alltrue([for p in var.iam_policies :
      (p.policy_hcl == null && p.policy_yaml != null) ||
      (p.policy_hcl != null && p.policy_yaml == null)
    ])
    error_message = "`policy_hcl` or `policy_yaml` must be specified, but not both"
  }
}

variable "iam_users" {
  type = map(object({
    access_keys = optional(map(object({
      auto_rotate_days = optional(number)
      staggered_rotation = optional(object({
        overlap_days = optional(number, 10)
        rotate_days  = number
      }))
      status = optional(string, "Active")
      vault = optional(object({
        mount = string
        path  = string
      }))
    })), {})
    group_keys = set(string)
    path       = optional(string, "/")
    tags       = optional(map(string))
  }))
  default     = {}
  description = "A collection of IAM users to create"
}

variable "load_balancers" {
  type = map(object({
    external_tls_decryption        = optional(bool, false)
    alb_fips                       = optional(bool, false)
    alb_drop_invalid_header_fields = optional(bool, true)
    certificates = optional(map(object({
      # Map key = domain name
      subject_alternative_names = optional(list(string), [])
    })), {})
    deletion_protection    = optional(bool, true)
    deregistration_delay   = optional(number, 300)
    desync_mitigation_mode = optional(string, "defensive")
    idle_timeout           = optional(number, 60)
    internal               = bool
    listeners = map(object({
      default_cert_key    = optional(string)
      port                = number
      protocol            = string
      secondary_cert_keys = optional(list(string), [])
      default_action = object({
        fixed_response = optional(object({
          content_type = string
          message_body = optional(string)
          status_code  = optional(string)
        }))
        forward = optional(object({
          target_groups = map(object({
            key    = string
            weight = optional(number)
          }))
          stickiness = optional(object({
            enabled  = bool
            duration = optional(number)
          }))
        }))
        redirect = optional(object({
          host        = optional(string)
          path        = optional(string)
          port        = optional(string)
          protocol    = optional(string)
          query       = optional(string)
          status_code = string
        }))
        type             = string
        target_group_key = optional(string)
      })
      rules = optional(map(object({
        action = object({
          fixed_response = optional(object({
            content_type = string
            message_body = optional(string)
            status_code  = optional(string)
          }))
          forward = optional(object({
            target_groups = map(object({
              key    = string
              weight = optional(number)
            }))
            stickiness = optional(object({
              enabled  = bool
              duration = optional(number)
            }))
          }))
          redirect = optional(object({
            host        = optional(string)
            path        = optional(string)
            port        = optional(string)
            protocol    = optional(string)
            query       = optional(string)
            status_code = string
          }))
          type             = string
          target_group_key = optional(string)
        })
        conditions = map(object({
          host_header = optional(list(string))
          http_header = optional(object({
            http_header_name = string
            values           = list(string)
          }))
          http_request_method = optional(list(string))
          path_pattern        = optional(list(string))
          query_string = optional(map(object({
            key   = string
            value = string
          })))
          source_ip = optional(list(string))
        }))
        priority = optional(number)
      })), {})
    }))
    nlb_dns_record_client_routing_policy = optional(string, "any_availability_zone")
    nlb_network_cross_zone               = optional(bool, false)
    redirect_80_to_443                   = bool
    # Not to be used together. Only specify subnet_id if the VPC isn't managed by Terraform
    # subnet_keys must be used with vpc_key
    subnet_ids  = optional(list(string))
    subnet_keys = optional(list(string))
    tags        = optional(map(string))
    # Must start with "tg-". Max of 26 characters total. Port will be auto-appended
    target_groups = map(object({
      health_check = object({
        path     = optional(string)
        port     = number
        protocol = string
        matcher  = optional(string, "200")
      })
      nlb_connection_termination      = optional(bool, false)
      alb_target_for_port_80_listener = optional(bool, false)
      nlb_preserve_client_ip          = optional(bool)
      nlb_targets_outside_vpc         = optional(bool, false)
      port                            = number
      protocol                        = string
      stickiness = optional(object({
        cookie_duration = optional(number, 86400)
        cookie_name     = optional(string)
        enabled         = optional(bool, true)
        type            = string
      }))
      targets = set(string)
      type    = string
    }))
    type = string
    # Not to be used together. Only specify vpc_id if the VPC isn't managed by Terraform
    # vpc_key must be used with subnet_keys
    vpc_id  = optional(string)
    vpc_key = optional(string)
  }))
  description = "Map of objects used to create load balancers"
  default     = {}

  validation {
    condition = alltrue([for lb in var.load_balancers : (
      (lb.subnet_keys != null && lb.vpc_key != null &&
      lb.subnet_ids == null && lb.vpc_id == null) ||
      (lb.subnet_ids != null && lb.vpc_id != null &&
      lb.subnet_keys == null && lb.vpc_key == null)
    )])
    error_message = "Must specify either subnet_ids or subnet_keys, but not both."
  }
}

variable "management_account_role" {
  type        = string
  description = "The org management role to assume when creating the AWS account"
}

variable "network_account_id" {
  type        = string
  description = "The network account ID in the org"
}

variable "organization" {
  type = object({
    aws_service_access_principals = optional(list(string))
    feature_set                   = optional(string, "ALL")
    enabled_policy_types          = optional(list(string))
    policies = map(object({
      description = string
      content     = string
      type        = optional(string, "SERVICE_CONTROL_POLICY")
      targets     = optional(list(string), [])
    }))
    organizational_units = map(any)
    tags                 = optional(map(string))
  })
  description = "Object to create the AWS Organization"
  default     = null
}

variable "profile" {
  type        = string
  description = "The AWS profile to use"
  default     = null
}

variable "region" {
  type        = string
  description = "The AWS region where resources will be created"

  validation {
    condition = contains([
      "ca-central-1",
      "me-south-1",
      "us-east-1",
      "us-east-2",
      "us-gov-east-1",
      "us-gov-west-1",
      "us-west-2",
    ], var.region)
    error_message = "Must specify a Parsons-supported region"
  }
}

# tflint-ignore: terraform_unused_declarations
variable "root_ou" {
  type        = string
  default     = null
  description = "This is only used by a Python script, but is here to suppress a warning."
}

variable "sso_region" {
  type        = string
  description = "The region where SSO resides, as SSO assignments will be created"
}

variable "tgw_route_tables" {
  type = map(object({
    override_blackhole_cidrs = optional(set(string))
    tags                     = optional(map(string))
    transit_gateway_key      = optional(string)
    vpc_keys                 = optional(list(string), [])
  }))
  description = <<-EOL
  A map of transit gateway route table objects. To create an empty, central route table
  for a transit gateway, only specify `transit_gateway_id`. For a route table for a
  DMZ VPC, specify `vpc_keys` and the optional blackhole override.
  EOL
  default     = {}

  validation {
    condition = alltrue([
      for v in var.tgw_route_tables : ((
        v.transit_gateway_key != null && length(v.vpc_keys) == 0 &&
        v.override_blackhole_cidrs == null
        ) || (
        length(v.vpc_keys) > 0 && v.transit_gateway_key == null
      ))
    ])
    error_message = <<-EOL
    You must use `transit_gateway_key` and `vpc_keys` (with optional blackhole override)
    exclusively of one another.
    EOL
  }
}

variable "transit_gateways" {
  type = map(object({
    amazon_side_asn                 = optional(number, 64512)
    auto_accept_shared_attachments  = optional(bool, false)
    cidr_blocks                     = optional(list(string))
    default_route_table_association = optional(bool, false)
    default_route_table_propagation = optional(bool, false)
    description                     = string
    dns_support                     = optional(bool, true)
    share_to_principals             = optional(set(string), [])
    tags                            = optional(map(string), {})
    vpn_ecmp_support                = optional(bool, true)
  }))
  description = "A map of transit gateway objects to create"
  default     = {}
}

variable "username" {
  type        = string
  description = "The username of the person running Terraform in Vagrant, or 'jenkins'"
}

variable "vpcs" {
  type = map(object({
    cidr_block = string
    dhcp_options = optional(object({
      domain_name         = string
      domain_name_servers = optional(list(string), [])
      # Type = set so for_each can be used
      resolver_rule_ids = optional(set(string), [])
    }))
    enable_dns_hostnames   = optional(bool, true)
    enable_dns_support     = optional(bool, true)
    flowlog_retention_days = optional(number, 30)
    flowlog_traffic_type   = optional(string, "ALL")
    instance_tenancy       = optional(string, "default")
    tags                   = optional(map(string))
    transit_gateway_id     = string
    private_subnets = map(object({
      availability_zone = string
      cidr_block        = string
    }))
  }))
  description = "Map of objects used to create VPCs"
  default     = {}
}
