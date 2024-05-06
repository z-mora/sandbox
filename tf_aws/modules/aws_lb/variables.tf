variable "alb_drop_invalid_header_fields" {
  type        = bool
  description = <<EOL
  ALB only variable that determines whether the load balancer will drop invalid header
  fields or keep them.
  EOL
  default     = true
}

variable "external_tls_decryption" {
  type        = bool
  description = <<EOL
  Are we enabling external TLS decryption for
  the Palo Alto? True indicates that the HTTP/80 to HTTPS/443 redirect won't occur if
  coming from the internet through the Palo Alto.
  EOL
  default     = false
}

variable "alb_fips" {
  type        = bool
  description = <<EOL
  This setting is only available for ALBs. Creates a FIPS enabled ALB.
  Note - this feature is still in AWS private preview
  EOL
  default     = false
}

variable "certificates" {
  type = map(object({
    # Map key = domain name
    subject_alternative_names = optional(list(string), [])
  }))
  description = <<EOL
  A map of certificates to create in ACM for the load balancer. Required if listeners
  are using HTTPS or TLS. The map key is the domain name. The certificates are
  automatically DNS validated in Route 53 in the Commercial support account.
  EOL
  default     = {}
}

variable "deletion_protection" {
  type        = bool
  description = "Enable or disable deletion protection for the LB."
  default     = true
}

variable "deregistration_delay" {
  type        = number
  description = <<EOL
  The amount of time, in seconds, that the LB will wait to change the state of the
  deregistering target from draining to unused. Range is 0-3600 seconds.
  EOL
  default     = 300
}

variable "desync_mitigation_mode" {
  type        = string
  description = "Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync"
  default     = "defensive"
}

variable "idle_timeout" {
  type        = number
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application"
  default     = 60
}

variable "internal" {
  type        = bool
  description = "If the load balancer is internal or external"
}

variable "is_gov" {
  type        = bool
  description = "If the LB is being deployed in Commercial or GovCloud"
}

variable "listeners" {
  type = map(object({
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
          key   = optional(string)
          value = string
        })), {})
        source_ip = optional(list(string))
      }))
      priority = optional(number)
    })), {})
  }))
  description = <<EOL
  A map of listeners to create and attach to the LB. If the protocol is HTTPS or TLS,
  a default_cert_key is required.
  EOL
}

variable "name" {
  type        = string
  description = "The name of the load balancer"

  validation {
    condition     = startswith(var.name, "nlb") || startswith(var.name, "alb")
    error_message = "The Load Balancer name must contain the prefix 'nlb' or 'alb"
  }

  validation {
    condition = anytrue([
      strcontains(var.name, "ext"),
      strcontains(var.name, "dmz"),
      strcontains(var.name, "int")
    ])
    error_message = "The Load Balancer name must contain 'ext', 'dmz', or 'int' depending on its network location"
  }

  validation {
    condition = anytrue([
      strcontains(var.name, "test"),
      strcontains(var.name, "dev"),
      strcontains(var.name, "prod"),
      strcontains(var.name, "qa"),
      strcontains(var.name, "dr")
    ])
    error_message = "The Load Balancer name must contain 'test', 'dev', 'qa', 'dr', or 'prod' depending on its use case"
  }
}

variable "nlb_dns_record_client_routing_policy" {
  type        = string
  default     = "any_availability_zone"
  description = <<-EOL
   Indicates how traffic is distributed among the load balancer Availability Zones.
   Possible values are any_availability_zone (default), availability_zone_affinity, or
   partial_availability_zone_affinity. See [Availability Zone DNS affinity](
     https://docs.aws.amazon.com/elasticloadbalancing/latest/network/network-load-balancers.html#zonal-dns-affinity
   ) for additional details. Only valid for network type load balancers. Not supported
   in GovCloud.
   EOL
}

variable "nlb_network_cross_zone" {
  type        = bool
  description = <<EOL
  This setting is only available for NLBs. Enable/disable cross-zone load balancing.
  For ALBs, this feature is always enabled and can't be disabled.
  EOL
  default     = false
}

variable "redirect_80_to_443" {
  type        = bool
  description = <<EOL
  Automatically creates resources/configuration to redirect port 80 to 443.
  For ALBs this redirects using a listener.
  For NLBs creates an ALB to use as a target group which then handles the redirect.
  EOL
}

variable "region" {
  type        = string
  description = "The AWS region where the LB is being deployed. Used for S3 bucket ARN."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to attach to the LB"
}

variable "tags" {
  nullable = false
  type = object({
    App         = optional(string)
    Environment = optional(string)
    GBU         = optional(string)
    ITSM        = optional(string, "NETWORK")
    JobWbs      = optional(string)
    Notes       = optional(string)
    Owner       = optional(string)
  })
  default     = {}
  description = "Optional tags to override provider defaults"

  validation {
    condition = try(
      contains(["DEV", "DR", "PROD", "QA", "TEST"], var.tags.Environment),
      var.tags.Environment == null, var.tags == null
    )
    error_message = "Environment tag must be one of: DEV, TEST, QA, PROD, DR"
  }

  validation {
    condition = try(
      contains(["COR", "FED", "INF", "MEA"], var.tags.GBU),
      var.tags.GBU == null, var.tags == null
    )
    error_message = "GBU tag must be one of: COR, FED, INF, MEA"
  }

  validation {
    condition = try(
      contains(["BACKUP", "DATABASE", "MANAGEMENT", "NETWORK", "SERVER", "STORAGE"], var.tags.ITSM),
      var.tags.ITSM == null, var.tags == null
    )
    error_message = "ITSM tag must be one of: BACKUP, DATABASE, MANAGEMENT, NETWORK, SERVER, STORAGE"
  }
  validation {
    condition = (
      can(regex("^\\d{6}-\\d{5}$", var.tags.JobWbs)) ||
      can(var.tags.JobWbs == null) || var.tags == null
    )
    error_message = "JobWbs tag must be digits in the format xxxxxx-xxxxx"
  }

  validation {
    condition = (
      can(regex("(?i)[A-Z0-9+_.-]+@[A-Z0-9.-]+", var.tags.Owner)) ||
      can(var.tags.Owner == null) || var.tags == null
    )
    error_message = "Owner tag must be a valid email address"
  }
}

variable "target_groups" {
  type = map(object({
    health_check = object({
      path     = optional(string)
      port     = number
      protocol = string
      matcher  = optional(string, null)
    })
    alb_target_for_port_80_listener = optional(bool, false)
    # NLB only. Indicates whether the NLB terminates connections after the end of the
    # deregistration timeout.
    nlb_connection_termination = optional(bool, false)
    port                       = number
    # Enable/disable source IP preservation on the Target Group. Not applicable with
    # UDP or TCP_UDP Target Groups.
    nlb_preserve_client_ip = optional(bool)
    protocol               = string
    stickiness = optional(object({
      cookie_duration = optional(number, 86400)
      cookie_name     = optional(string)
      enabled         = optional(bool, true)
      type            = string
    }))
    targets                 = set(string)
    nlb_targets_outside_vpc = optional(bool, false)
    type                    = string
  }))
  description = "Target groups to create and attach to the LB."
}

variable "type" {
  type        = string
  description = "The type of load balancer - application, gateway, or network"

  validation {
    condition     = var.type == "application" || var.type == "network"
    error_message = "Load balancer type must be application or network"
  }
}

variable "vpc_id" {
  type        = string
  description = "The VPC that resources will be created in."
}
