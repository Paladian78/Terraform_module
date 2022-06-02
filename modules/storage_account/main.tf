provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name = var.resorce_group_name
  location = var.location
}
output "rg_name" {
  value = azurerm_resource_group.main.resorce_group_name
}
  

resource "azurerm_storage_account" "main" {
  name                     = "functionsapptestsa"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
output "strg_name" {
  value = azurerm_storage_account.main.name
}
output "strg_key" {
  value = azurerm_storage_account.main.primary_access_key
}
  

  