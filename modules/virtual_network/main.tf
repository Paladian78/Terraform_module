resource "azurerm_virtual_network" "vm_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.service_rg_name
  address_space       = var.virtual_network_address
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}


resource "azurerm_subnet" "vm_subnet" {
  name                 = "frontend"
  resource_group_name  = var.service_rg_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = var.subnet_frontend_address
  
}

resource "azurerm_subnet" "backend" {
  name                                          = "backend"
  resource_group_name                           = var.service_rg_name
  virtual_network_name                          = azurerm_virtual_network.vm_vnet.name
  address_prefixes                              = var.subnet_backend_address
  enforce_private_link_service_network_policies = true
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "app_gateway_subnet"
  resource_group_name  = var.service_rg_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = var.appg_subnet
}


output "ag_subnet_id" {
  value = azurerm_subnet.app_gateway_subnet.id
}
output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}
output "backend_subnet_id" {
  value = azurerm_subnet.backend.id
}
