provider "azurerm" {
  features {}
}
  
module "storage_account" {
  source = "./modules/storage_account"
  resource_group_name = var.resorce_group_name
    location = var.location
}

module "logic_app" {
  source = "./modules/logic_app"
  resource_group_name = module.storage_account.rg_name
    location = var.location
    storage_account_name = module.storage_account.strg_name
    storage_account_access_key = module.storage_account.strg_key
}