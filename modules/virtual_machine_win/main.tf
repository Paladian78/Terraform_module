# Windows VM
resource "azurerm_network_security_group" "win_nsg" {
  name                = "network-security-group-${var.windows}"
  location            = var.location
  resource_group_name = var.vnet_rg_name
}

resource "azurerm_subnet" "win_subnet" {
  name                 = "subnet-windows"
  resource_group_name  = var.vnet_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "win_pi" {
  name                = "public-ip-${var.windows}"
  resource_group_name = var.service_rg_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "win_nic" {
  name                = "nic-${var.windows}"
  location            = var.location
  resource_group_name = var.service_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.win_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_pi.id
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

resource "azurerm_subnet_network_security_group_association" "win_subnet_nsg" {
  subnet_id                 = azurerm_subnet.win_subnet.id
  network_security_group_id = azurerm_network_security_group.win_nsg.id
}
