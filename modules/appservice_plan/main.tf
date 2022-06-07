provider "azurerm" {
  features {}
}

resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.service_rg_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}
output "app_service_plan_id" {
  value = azurerm_service_plan.plan.id
}

