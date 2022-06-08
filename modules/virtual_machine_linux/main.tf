# Linux Virtual Machine
resource "azurerm_network_security_group" "linux_nsg" {
  name                = "linux-nsg-${var.linux}"
  location            = var.location
  resource_group_name = var.vnet_rg_name
}

resource "azurerm_public_ip" "linux_pi" {
  name                = "linux-publicIP-${var.linux}"
  resource_group_name = var.service_rg_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "linux_nic" {
  name                = "linux-nic-${var.linux}"
  location            = var.location
  resource_group_name = var.service_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pi.id
  }
}

resource "azurerm_network_interface_security_group_association" "netwrk" {
  network_interface_id      = azurerm_network_interface.linux_nic.id
  network_security_group_id = azurerm_network_security_group.linux_nsg.id
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
    admin_username = var.linux_admin_username
    admin_password = var.linux_admin_password
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


output "sec_grp" {
  value = azurerm_network_security_group.linux_nsg.name
}

output "sec_grp_id" {
  value = azurerm_network_security_group.linux_nsg.id
}
