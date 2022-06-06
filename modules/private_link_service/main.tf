
resource "azurerm_lb" "pls_lb" {
  name                = "pls-lb"
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.service_rg_name

  frontend_ip_configuration {
    name                 = var.ag_public_ip_name
    public_ip_address_id = var.ag_public_ip_id
  }
}

resource "azurerm_private_link_service" "pls_private_link" {
  name                = var.privatelink_name
  resource_group_name = var.service_rg_name
  location            = var.location

  auto_approval_subscription_ids              = ["00000000-0000-0000-0000-000000000000"]
  visibility_subscription_ids                 = ["00000000-0000-0000-0000-000000000000"]
  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.pls_lb.frontend_ip_configuration.0.id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = "10.5.1.17"
    private_ip_address_version = "IPv4"
    subnet_id                  = var.ag_public_ip_id
    primary                    = true
  }

  nat_ip_configuration {
    name                       = "secondary"
    private_ip_address         = "10.5.1.18"
    private_ip_address_version = "IPv4"
    subnet_id                  = var.ag_public_ip_id
    primary                    = false
  }
}
