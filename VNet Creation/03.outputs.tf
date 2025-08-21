output "deployment_info" {
  description = "Infra Deployment details"
  value = {
    vnet_name             = azurerm_virtual_network.vnet.name
    vm_name               = azurerm_virtual_machine.main.name
  }
}