moved {
  from = azurerm_virtual_machine_extension.build_script
  to   = azurerm_virtual_machine_extension.domain_join
}

moved {
  from = azurerm_network_interface.network_interface
  to   = azurerm_network_interface.this
}

moved {
  from = azurerm_windows_virtual_machine.windowsvm
  to   = azurerm_windows_virtual_machine.this
}

moved {
  from = azurerm_managed_disk.managed_disk
  to   = azurerm_managed_disk.this
}

moved {
  from = azurerm_virtual_machine_data_disk_attachment.managed_disk
  to   = azurerm_virtual_machine_data_disk_attachment.this
}
