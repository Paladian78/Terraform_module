provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "acctestcont"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

output "strg_key" {
  value = azurerm_storage_account.main.primary_access_key
}
output "storage_id" {
  value = azurerm_storage_account.main.id
}