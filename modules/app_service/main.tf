provider "azurerm" {
  features {}
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.service_rg_name
  app_service_plan_id = var.app_service_plan_id

  site_config {}
  }

