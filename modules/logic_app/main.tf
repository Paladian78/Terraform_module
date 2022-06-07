resource "azurerm_service_plan" "lg_plan" {
  name                = var.logic_app_service_plan_name
  location            = var.location
  resource_group_name = var.service_rg_name
  sku_name            = "WS1"
  os_type             = "Linux" 
}

resource "azurerm_logic_app_standard" "lg_app" {
  name                       = var.logic_app_name
  location                   = var.location
  resource_group_name        = var.service_rg_name
  app_service_plan_id        = azurerm_service_plan.lg_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
}
