resource "azurerm_virtual_network" "pls_vnet" {
  name                = "pls-network"
  resource_group_name = var.service_rg_name
  location            = var.location
  address_space       = ["10.5.0.0/16"]
}

resource "azurerm_subnet" "pls_subnet" {
  name                                          = "pls-subnet"
  resource_group_name                           = var.service_rg_name
  virtual_network_name                          = azurerm_virtual_network.pls_vnet.name
  address_prefixes                              = ["10.5.1.0/24"]
  enforce_private_link_service_network_policies = true
}

resource "azurerm_public_ip" "pls_public_ip" {
  name                = "pls-api"
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.service_rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "pls_lb" {
  name                = "pls-lb"
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.service_rg_name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.pls_public_ip.name
    public_ip_address_id = azurerm_public_ip.pls_public_ip.id
  }
}

resource "azurerm_private_link_service" "pls_private_link" {
  name                = "pls-privatelink"
  resource_group_name = var.service_rg_name
  location            = var.location

  auto_approval_subscription_ids              = ["00000000-0000-0000-0000-000000000000"]
  visibility_subscription_ids                 = ["00000000-0000-0000-0000-000000000000"]
  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.pls_lb.frontend_ip_configuration.0.id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = "10.5.1.17"
    private_ip_address_version = "IPv4"
    subnet_id                  = azurerm_subnet.pls_subnet.id
    primary                    = true
  }

  nat_ip_configuration {
    name                       = "secondary"
    private_ip_address         = "10.5.1.18"
    private_ip_address_version = "IPv4"
    subnet_id                  = azurerm_subnet.pls_subnet.id
    primary                    = false
  }
}
