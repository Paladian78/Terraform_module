resource "azurerm_public_ip" "main" {
  name                = "plsip-public"
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
    name                 = azurerm_public_ip.main.name
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_private_link_service" "pls_private_link" {
  name                                        = var.privatelink_name
  resource_group_name                         = var.service_rg_name
  location                                    = var.location
  auto_approval_subscription_ids              = ["00000000-0000-0000-0000-000000000000"]
  visibility_subscription_ids                 = ["00000000-0000-0000-0000-000000000000"]
  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.pls_lb.frontend_ip_configuration.0.id]
  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = var.privateip1
    private_ip_address_version = "IPv4"
    subnet_id                  = var.ag_subnet_id
    primary                    = true
  }
  nat_ip_configuration {
    name                       = "secondary"
    private_ip_address         = var.privateip2
    private_ip_address_version = "IPv4"
    subnet_id                  = var.ag_subnet_id
    primary                    = false
  }
}
