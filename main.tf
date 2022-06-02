provider "azurerm" {
  features {}
}
  
module "storage_account" {
  source = "./modules/storage_account"
  resource_group_name = "myrggrp"
    location = "eastasia"
    storage_account_name = "functionsapptestsamystrg"
}

module "logic_app" {
  source = "./modules/logic_app"
  resource_group_name = module.storage_account.rg_name
    location = var.location
    storage_account_name = module.storage_account.strg_name
    storage_account_access_key = module.storage_account.strg_key
}

# module "key_vault" {
#   source = "./modules/key_vault"
#   resource_group_name = module.storage_account.rg_name
#     location = var.location
#     key_vault_name = "test-key-vault"
# }
  
module "function_app" {
  source = "./modules/function_app"

    resource_group_name = module.storage_account.rg_name
    location = var.location
    storage_account_name = module.storage_account.strg_name
    storage_account_access_key = module.storage_account.strg_key
    function_app_name = "test-azure-functions"
}
