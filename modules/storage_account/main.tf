provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "strg_key" {
  value = azurerm_storage_account.main.primary_access_key
}
