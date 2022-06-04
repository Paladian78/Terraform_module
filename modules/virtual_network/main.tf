resource "azurerm_virtual_network" "vm_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.service_rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

output "vnet_name" {
  value = azurerm_virtual_network.vm_vnet.name
}
