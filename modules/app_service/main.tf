
  
resource "azurerm_service_plan" "main" {
  name                = "${var.prefix}-aappsp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "main" {
  name                = "${var.prefix}-basic-xample"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {}
}