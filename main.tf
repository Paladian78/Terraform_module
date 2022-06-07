# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#--------------------------------------resource group--------------------------------------#

resource "azurerm_resource_group" "rg_name" {
  name     = var.service_rg_name
  location = var.location
}

#--------------------------------------resource group for virtual network--------------------------------------#

resource "azurerm_resource_group" "vnet_rg" {
  name     = var.vnet_rg_name
  location = var.location
}


#--------------------------------------virtual network--------------------------------------#

module "virtual_network" {
  source          = "./modules/virtual_network"
  service_rg_name = azurerm_resource_group.vnet_rg.name
  vnet_name       = var.vnet_name
  location        = var.location
  virtual_network_address = var.virtual_network_address
  subnet_frontend_address = var.subnet_frontend_address
  subnet_backend_address = var.subnet_backend_address
  appg_subnet         = var.appg_subnet
}

#--------------------------------------linux virtual machine--------------------------------------#

module "virtual_machine_linux" {
  source               = "./modules/virtual_machine_linux"
  service_rg_name      = azurerm_resource_group.rg_name.name
  vnet_rg_name         = azurerm_resource_group.vnet_rg.name
  location             = azurerm_resource_group.rg_name.location
  vnet_name            = module.virtual_network.vnet_name
  subnet_id            = module.virtual_network.vm_subnet_id
  linux                = var.linux
  linux_admin_username = var.linux_admin_username
  linux_admin_password = var.linux_admin_password
}

#--------------------------------------windows virtual machine--------------------------------------#

module "virtual_machine_win" {
  source                 = "./modules/virtual_machine_win"
  service_rg_name        = azurerm_resource_group.rg_name.name
  vnet_rg_name           = azurerm_resource_group.vnet_rg.name
  location               = azurerm_resource_group.rg_name.location
  vnet_name              = module.virtual_network.vnet_name
  subnet_id              = module.virtual_network.vm_subnet_id
  windows                = var.windows
  windows_name           = var.windows_name
  windows_admin_username = var.windows_admin_username
  windows_admin_password = var.windows_admin_password
}

#--------------------------------------event hub--------------------------------------#

module "eventhub" {
  source          = "./modules/eventhub"
  service_rg_name = azurerm_resource_group.rg_name.name
  location        = azurerm_resource_group.rg_name.location
  namespace_name  = var.namespace_name
  eventhub_name   = var.eventhub_name
}

#--------------------------------------SQL instance--------------------------------------#

module "sql" {
  source               = "./modules/sql"
  service_rg_name      = azurerm_resource_group.rg_name.name
  location             = var.location
  mysql_server_name    = var.mysql_server_name
  mysql_database_name  = var.mysql_database_name
  mysql_admin_login    = var.mysql_admin_login
  mysql_admin_password = var.mysql_admin_password
  sec_grp              = module.virtual_machine_linux.sec_grp
  sec_grp_id           = module.virtual_machine_linux.sec_grp_id
  vnet_name            = module.virtual_network.vnet_name
}

module "sql_instance" {
  source                    = "./modules/sql_instance"
  service_rg_name           = azurerm_resource_group.rg_name.name
  location                  = var.location
  sql_managed_instance_name = var.sql_managed_instance_name
  subnet_id                 = module.virtual_network.backend_subnet_id
}
  

#--------------------------------------storage account--------------------------------------#

module "storage_account" {
  source               = "./modules/storage_account"
  service_rg_name      = azurerm_resource_group.rg_name.name
  location             = var.location
  storage_account_name = var.storage_account_name
}

#--------------------------------------logic app--------------------------------------#

module "logic_app" {
  source                      = "./modules/logic_app"
  service_rg_name             = azurerm_resource_group.rg_name.name
  location                    = var.location
  storage_account_name        = var.storage_account_name
  storage_account_access_key  = module.storage_account.strg_key
  logic_app_name              = var.logic_app_name
  logic_app_service_plan_name = var.logic_app_service_plan_name
}

#--------------------------------------key vault--------------------------------------#

module "key_vault" {
  source              = "./modules/key_vault"
  service_rg_name = azurerm_resource_group.rg_name.name
  location            = var.location
  key_vault_name      = "test-key-vault-0406"
}

#--------------------------------------function app--------------------------------------#

module "appservice_plan" {
  source                = "./modules/appservice_plan"
  service_rg_name   = azurerm_resource_group.rg_name.name
  location              = var.location
  app_service_plan_name = var.functionapp_plan_name
  appservice_tier       = var.apappservice_tier
  appservice_size       = var.apappservice_size
}

module "function_app" {
  source = "./modules/function_app"
  service_rg_name        = azurerm_resource_group.rg_name.name
  location                   = var.location
  storage_account_name       = var.storage_account_name
  storage_account_access_key = module.storage_account.strg_key
  function_app_name          = var.function_app_name
  app_service_plan_id        = module.appservice_plan.app_service_plan_id
}

#--------------------------------------app service--------------------------------------#


module "app_service" {
  source              = "./modules/app_service"
  service_rg_name = azurerm_resource_group.rg_name.name
  location            = var.location
  app_name            = var.appservice_name
  app_service_plan_id = module.appservice_plan.app_service_plan_id
}

#--------------------------------------waf policy--------------------------------------#

module "waf_policy" {
  source              = "./modules/waf_policy"
  service_rg_name = azurerm_resource_group.rg_name.name
  location            = var.location
  waf_policy_name     = var.waf_policy_name
}

#--------------------------------------application gateway--------------------------------------#

module "app_gateway" {
  source              = "./modules/app_gateway"
  service_rg_name = azurerm_resource_group.rg_name.name
  location            = var.location
  app_gateway_name    = var.app_gateway_name
  waf_policy_id       = module.waf_policy.waf_policy_id
  ag_public_ip_name   = var.ag_public_ip_name
  ag_subnet_id        = module.virtual_network.ag_subnet_id
}

#--------------------------------------private link service--------------------------------------#

module "private_link_service" {
  source            = "./modules/private_link_service"
  service_rg_name   = azurerm_resource_group.rg_name.name
  ag_public_ip_name = var.ag_public_ip_name
  location          = var.location
  ag_public_ip_id   = module.app_gateway.ag_public_ip_id
  ag_subnet_id      = module.virtual_network.backend_subnet_id
  privatelink_name  = var.privatelink_name
  privateip1        = var.privateip1
  privateip2        = var.privateip2
}