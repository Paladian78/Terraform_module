variable "service_rg_name" {
    type = string
}
variable "location" {
    type = string
}
variable "vnet_rg_name" {
    type = string
}
variable "storage_account_name" {
    type = string
}
variable "vnet_name" {
    type = string
}
variable "linux" {                  #used as prefix for linux vm
    type = string
}                   
variable "linux_admin_username" {
    type = string
}
variable "linux_admin_password" {
    type = string
}
variable "windows" {                #used as prefix for windows vm
    type = string
}                 
variable "windows_name" {
    type = string
}
variable "windows_admin_username" {
    type = string
}
variable "windows_admin_password" {
    type = string
}
variable "namespace_name" {
    type = string
}
variable "eventhub_name" {
    type = string
}
variable "logic_app_name" {
    type = string
}
variable "logic_app_service_plan_name" {
    type = string
}
variable "apappservice_tier" {
    type = string
}
variable "apappservice_size" {
    type = string
}
variable "function_app_name" {
    type = string
}
variable "functionapp_plan_name" {
    type = string
}
variable "fnappservice_tier" {
    type = string
}
variable "fnappservice_size" {
    type = string
}
variable "appservice_name" {
    type = string
}
variable "appservice_plan_name" {
    type = string
}
variable "waf_policy_name" {
    type = string
}
variable "app_gateway_name" {
    type = string
}
variable "ag_public_ip_name" {
    type = string
}
variable "privatelink_name" {
    type = string
}
variable "mysql_server_name" {
    type = string
}
variable "mysql_database_name" {
    type = string
}
variable "mysql_admin_login" {
    type = string
}
variable "mysql_admin_password" {
    type = string
}
variable "mysql_admin_username" {
    type = string
}
variable "virtual_network_address" {
    type = list(string)
}
variable "subnet_frontend_address" {
    type = list(string)
}
variable "subnet_backend_address" {
    type = list(string)
}
variable "appg_subnet" {
    type = list(string)
}
variable "privateip1" {
    type = string
}
variable "privateip2" {
    type = string
}
variable "sql_managed_instance_name" {
    type = string
}
variable "sku_name" {
    type = string
}
variable "key_vault_name" {
    type = string
}
  

  