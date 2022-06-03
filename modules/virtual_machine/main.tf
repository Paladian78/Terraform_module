provider "azurerm" {
  features {}
}

# Linux Virtual Machine
resource "azurerm_network_security_group" "linux_nsg" {
  name                = "network-security-group-${var.linux}"
  location            = var.location
  resource_group_name = var.service_rg_name
}

resource "azurerm_virtual_network" "linux_vnet" {
  name                = "vnet-${var.linux}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.service_rg_name
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = "subnet-${var.linux}"
  resource_group_name  = var.service_rg_name
  virtual_network_name = azurerm_virtual_network.linux_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "linux_nic" {
  name                = "nic-${var.linux}"
  location            = var.location
  resource_group_name = var.service_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "linux_vm" {
  name                  = var.linux
  location              = var.location
  resource_group_name   = var.service_rg_name
  network_interface_ids = [azurerm_network_interface.linux_nic.id]
  vm_size               = "Standard_F2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.linux
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_managed_disk" "linux_disk" {
  name                 = "disk1-${var.linux}"
  location             = var.location
  resource_group_name  = var.service_rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_dd_attach" {
  managed_disk_id    = azurerm_managed_disk.linux_disk.id
  virtual_machine_id = azurerm_virtual_machine.linux_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}


#------------------------------------------------------------------------------#

# Windows VM
resource "azurerm_network_security_group" "win_nsg" {
  name                = "network-security-group-${var.windows}"
  location            = var.location
  resource_group_name = var.service_rg_name
}

resource "azurerm_virtual_network" "win_vnet" {
  name                = "vnet-${var.windows}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.service_rg_name
}

resource "azurerm_subnet" "win_subnet" {
  name                 = "subnet-${var.windows}"
  resource_group_name  = var.service_rg_name
  virtual_network_name = azurerm_virtual_network.win_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "win_nic" {
  name                = "nic-${var.windows}"
  location            = var.location
  resource_group_name = var.service_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.win_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  name                = var.windows
  resource_group_name = var.service_rg_name
  location            = var.location
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  size                = "Standard_F2"

  network_interface_ids = [
    azurerm_network_interface.win_nic.id,
  ]

  os_disk {
    name                 = "myosdisk2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

resource "azurerm_managed_disk" "win_disk" {
  name                 = "disk1-${var.windows}"
  location             = var.location
  resource_group_name  = var.service_rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "win_dd_attach" {
  managed_disk_id    = azurerm_managed_disk.win_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.win_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}


output "vnet" {
  value = azurerm_virtual_network.linux_vnet.name
}

output "sec_grp" {
  value = azurerm_network_security_group.linux_nsg.name
}

output "sec_grp_id" {
  value = azurerm_network_security_group.linux_nsg.id
}
