provider "azurerm" {
  features {}
}

# resource "azurerm_resource_group" "main" {
#   name = var.resource_group_name
#   location = var.location
# }

  

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
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
  

  