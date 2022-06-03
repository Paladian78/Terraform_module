# terraform{
#   required_providers{
#     azurerm{
#       source= "hashicorp/azurerm"
#       version = "=3.0.0"
#     }
#   }
# }

provider "azurerm" {
  
  features {}
}
  
module "storage_account" {
  source = "./modules/storage_account"
  resource_group_name = var.resource_group_name
    location = "eastasia"
    storage_account_name = var.storage_account_name
}

#######################################LOGIC APP##############################################

module "appservice_plan_logic_app" {
  source = "./modules/appservice_plan"
  resource_group_name = var.resource_group_name
    location = "eastasia"
    app_service_plan_name = "myappserviceplan_logicaapp"
}
module "logic_app" {
  source = "./modules/logic_app"
  resource_group_name = var.resource_group_name
    location = var.location
    storage_account_name = var.storage_account_name
    storage_account_access_key = module.storage_account.strg_key
    app_service_plan_id = module.appservice_plan_logic_app.app_service_plan_id
}


#######################################KEY VAULT##############################################

# module "key_vault" {
#   source = "./modules/key_vault"
#   resource_group_name = var.resource_group_name
#     location = var.location
#     key_vault_name = "test-key-vault"
# }
  

#######################################FUNCTION APP##############################################

module "appservice_plan_function_app" {
  source = "./modules/appservice_plan"
  resource_group_name = var.resource_group_name
    location = "eastasia"
    app_service_plan_name = "myappserviceplan_functionaapp"
}
module "function_app" {
  source = "./modules/function_app"

    resource_group_name = var.resource_group_name
    location = var.location
    storage_account_name = var.storage_account_name
    storage_account_access_key = module.storage_account.strg_key
    function_app_name = "test-azure-functions"
    app_service_plan_id = module.appservice_plan_function_app.app_service_plan_id
}


#######################################App Service##############################################

module "appservice_plan_app_service" {
  source = "./modules/appservice_plan"
  resource_group_name = var.resource_group_name
    location = "eastasia"
    app_service_plan_name = "myappserviceplan_appservicee"
}
module "app_service" {
  source = "./modules/app_service"
  resource_group_name = var.resource_group_name
    location = var.location
    function_app_name = "azure-functions_app_service"
    app_service_plan_id = module.appservice_plan_app_service.app_service_plan_id
}




#######################################Application Gateway##############################################

# module "waf_policy" {
#   source = "./modules/waf_policy"
#   resource_group_name = var.resource_group_name
#     location = var.location
#     waf_policy_name = "test-azure-functions-waf-policy-myywaf"
# }
  
# module "app_gateway" {
#   source = "./modules/app_gateway"
#   resource_group_name = var.resource_group_name
#     location = var.location
#     app_gateway_name = "myaaapp-gateway-myappgw"
#     waf_policy_id = module.waf_policy.waf_policy_id
# }
  
