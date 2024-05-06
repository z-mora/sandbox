load_balancers = {
  "lb-inf-pla-globalstar-prod-ext-01" = {
    backend_pool_addresses = {
      "lb-inf-pla-globalstar-prod-ext-backend-pool-01" = {
        backend_ip_address        = "10.208.2.4"
        backend_pool_address_name = "lb-inf-pla-globalstar-prod-ext-backend-pool-01"
      }
      "lb-inf-pla-globalstar-prod-ext-backend-pool-02" = {
        backend_ip_address        = "10.208.2.5"
        backend_pool_address_name = "lb-inf-pla-globalstar-prod-ext-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-inf-pla-globalstar-prod-ext-backend-pool-01"
    frontend_name        = "lb-inf-pla-globalstar-prod-ext-frontend-01"
    frontend_subnet      = "subnet-palo_untrust-prod-01"
    internal_or_external = "external"
    load_balancer_rules = {
      "tcp-443-to-20026" = {
        backend_port          = 20026
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-inf-pla-globalstar-dev-ext-probe-01"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
    }
    location             = "eastus2"
    public_ip_name       = "pip-inf-pla-globalstar-dev-ext-01"
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
}
