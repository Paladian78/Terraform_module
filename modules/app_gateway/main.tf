

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "app_gateway_subnet"
  resource_group_name  = var.service_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.3.0/24"]
}


resource "azurerm_public_ip" "main" {
  name                 = var.ag_public_ip_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  allocation_method    = "Static"
  sku                  = "Standard"
  # enforce_private_link_service_network_policies = true
}
output "ag_public_ip_id" {
  value = azurerm_public_ip.main.id
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.vnet_name}-beap"
  frontend_port_name             = "${var.vnet_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_name}-feip"
  http_setting_name              = "${var.vnet_name}-be-htst"
  listener_name                  = "${var.vnet_name}-httplstn"
  request_routing_rule_name      = "${var.vnet_name}-rqrt"
  redirect_configuration_name    = "${var.vnet_name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 4
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.main.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = 2
  }
}


# resource "azurerm_web_application_firewall_policy_application_gateway_association" "main" {
#   association_type        = "ApplicationGateway"
#   waf_policy_id           = var.waf_policy_id
#   application_gateway_id  = azurerm_application_gateway.main.id
# }
