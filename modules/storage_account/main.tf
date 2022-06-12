resource "azurerm_storage_account" "strg" {
  name                     = var.storage_account_name
  resource_group_name      = var.service_rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
output "strg_key" {
  value = azurerm_storage_account.strg.primary_access_key
}
output "storage_id" {
  value = azurerm_storage_account.strg.id
}