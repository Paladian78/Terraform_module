provider "azurerm" {
  features {}
}
  
resource "azurerm_app_service_plan" "main" {
  name                = "azure-functions-test-service-plan"
  location            = var.location
  resource_group_name = var.resorce_group_name

  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }
}

resource "azurerm_logic_app_standard" "main" {
  name                       = "test-azure-functions"
  location                   = var.location
  resource_group_name        = var.resorce_group_name
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
}