resource "azurerm_vpn_site" "this" {
  for_each = var.vpn_sites

  device_model        = each.value.device_model
  device_vendor       = each.value.device_vendor
  location            = each.value.location
  name                = each.key
  resource_group_name = var.resource_group_name
  tags                = var.required_tags
  virtual_wan_id      = azurerm_virtual_wan.this.id

  link {
    ip_address    = each.value.site_link_ip_address
    name          = each.key
    provider_name = each.value.provider_name
    speed_in_mbps = each.value.speed_in_mbps

    bgp {
      asn             = each.value.asn
      peering_address = each.value.peering_address
    }
  }
}

resource "azurerm_vpn_gateway" "this" {
  for_each = var.virtual_hubs

  location            = each.value.location
  name                = each.value.vpn_gateway_name
  resource_group_name = var.resource_group_name
  routing_preference  = each.value.routing_preference # Options are "Microsoft Network" or "Internet"
  scale_unit          = each.value.scale_unit
  tags                = var.required_tags
  virtual_hub_id      = azurerm_virtual_hub.this[each.key].id

  bgp_settings {
    asn         = 65515
    peer_weight = 0

    instance_0_bgp_peering_address {
      custom_ips = each.value.instance_0_custom_ip
    }

    instance_1_bgp_peering_address {
      custom_ips = each.value.instance_1_custom_ip
    }
  }
}

resource "azurerm_vpn_gateway_connection" "hub_gateway_to_vpn_site" {
  for_each = var.vpn_sites

  name               = each.value.vpn_connection_name
  remote_vpn_site_id = azurerm_vpn_site.this[each.key].id
  vpn_gateway_id     = azurerm_vpn_gateway.this[each.value.virtual_hub_key].id

  vpn_link {
    bandwidth_mbps                        = 1000
    bgp_enabled                           = true
    connection_mode                       = "Default"
    local_azure_ip_address_enabled        = false
    name                                  = each.value.connection_link_name
    policy_based_traffic_selector_enabled = false
    protocol                              = "IKEv1"
    ratelimit_enabled                     = false
    vpn_site_link_id                      = azurerm_vpn_site.this[each.key].link[0].id

    ipsec_policy {
      dh_group                 = "DHGroup14"
      encryption_algorithm     = "AES256"
      ike_encryption_algorithm = "AES256"
      ike_integrity_algorithm  = "SHA256"
      integrity_algorithm      = "SHA256"
      pfs_group                = "PFS14"
      sa_data_size_kb          = each.value.sa_data_size_kb
      sa_lifetime_sec          = 3600
    }
  }

  lifecycle {
    ignore_changes = [vpn_gateway_id]
  }
}
