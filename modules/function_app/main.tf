provider "azurerm" {
  features {}
}

resource "azurerm_function_app" "main" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.service_rg_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
}
