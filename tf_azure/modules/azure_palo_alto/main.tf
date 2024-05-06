resource "null_resource" "palo_alto_agreement" {
  provisioner "local-exec" {
    command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol --subscription ${var.subscription_id}"
  }
}

resource "azurerm_public_ip" "this" {
  for_each = { for k, v in local.interfaces : k => v if v.create_public_ip }

  allocation_method   = "Static"
  location            = var.location
  name                = each.key
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.required_tags
  zones               = var.enable_zones ? var.public_ip_zones : null

  lifecycle {
    ignore_changes = [name]
  }
}

resource "azurerm_network_interface" "this" {
  for_each = local.interfaces

  # The management interface is interface 0 and doesn't support accelerated networking
  enable_accelerated_networking = each.value.index == 0 ? false : var.accelerated_networking
  # The management interface is interface 0 and shouldn't use IP forwarding
  enable_ip_forwarding = each.value.index == 0 ? false : each.value.enable_ip_forwarding
  location             = var.location
  name                 = each.key
  resource_group_name  = var.resource_group_name
  tags                 = var.required_tags

  ip_configuration {
    name                          = "primary"
    private_ip_address            = each.value.private_ip_address
    private_ip_address_allocation = each.value.private_ip_address == null ? "Dynamic" : "Static"
    public_ip_address_id          = try(azurerm_public_ip.this[each.key].id, null)
    subnet_id                     = data.azurerm_subnet.this[each.key].id
  }
}

resource "azurerm_virtual_machine" "this" {
  availability_set_id              = var.avset_id
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true
  location                         = var.location
  name                             = var.name
  network_interface_ids            = local.network_interface_ids
  primary_network_interface_id     = local.primary_network_interface_id
  resource_group_name              = var.resource_group_name
  tags                             = var.required_tags
  vm_size                          = var.vm_size
  zones                            = var.enable_zones && var.vm_zone != null ? [var.vm_zone] : null

  # After converting to azurerm_linux_virtual_machine, an empty block boot_diagnostics {} will use managed storage. Want.
  # 2.36 in required_providers per https://github.com/terraform-providers/terraform-provider-azurerm/pull/8917
  dynamic "boot_diagnostics" {
    for_each = var.diagnostics_storage_uri != null ? ["one"] : []
    content {
      enabled     = true
      storage_uri = var.diagnostics_storage_uri
    }
  }

  identity {
    identity_ids = var.identity_ids
    type         = var.identity_type
  }

  os_profile {
    admin_password = var.password
    admin_username = var.username
    computer_name  = var.name
    custom_data    = var.bootstrap_options
  }

  os_profile_linux_config {
    disable_password_authentication = var.password == null ? true : false
    dynamic "ssh_keys" {
      for_each = var.ssh_keys
      content {
        key_data = ssh_keys.value
        path     = "/home/${var.username}/.ssh/authorized_keys"
      }
    }
  }

  plan {
    name      = var.img_sku
    product   = var.img_offer
    publisher = var.img_publisher
  }

  storage_image_reference {
    offer     = var.img_offer
    publisher = var.img_publisher
    sku       = var.img_sku
    version   = var.img_version
  }

  storage_os_disk {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
    name              = coalesce(var.os_disk_name, "${var.name}-vhd")
    os_type           = "Linux"
  }

  lifecycle {
    ignore_changes = [storage_os_disk["name"]]
  }
}

resource "azurerm_log_analytics_workspace" "this" {
  count = var.app_insights_settings != null && try(var.app_insights_settings.workspace_mode, true) ? 1 : 0

  location            = var.location
  name                = try(var.app_insights_settings.log_analytics_name, "${var.name}-Workspace")
  resource_group_name = var.resource_group_name # same RG, so no RBAC modification is needed
  retention_in_days   = try(var.app_insights_settings.metrics_retention_in_days, null)
  sku                 = try(var.app_insights_settings.log_analytics_sku, "PerGB2018")
  tags                = var.required_tags
}

resource "azurerm_application_insights" "this" {
  count = var.app_insights_settings != null ? 1 : 0

  application_type    = "other"
  location            = var.location
  name                = try(var.app_insights_settings.name, "${var.name}-AppInsights")
  resource_group_name = var.resource_group_name # same RG, so no RBAC modification is needed
  retention_in_days   = try(var.app_insights_settings.metrics_retention_in_days, null)
  tags                = var.required_tags
  workspace_id        = try(var.app_insights_settings.workspace_mode, true) ? azurerm_log_analytics_workspace.this[0].id : null
}
