
  
resource "azurerm_app_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.main.id
}
  
