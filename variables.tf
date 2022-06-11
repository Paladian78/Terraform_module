variable "service_rg_name" {}
variable "location" {}
variable "vnet_rg_name" {}
variable "storage_account_name" {}
variable "vnet_name" {}
variable "linux" {}                   #used as prefix for linux vm
variable "linux_admin_username" {}
variable "linux_admin_password" {}
variable "windows" {}                 #used as prefix for windows vm
variable "windows_name" {}
variable "windows_admin_username" {}
variable "windows_admin_password" {}
variable "namespace_name" {}
variable "eventhub_name" {}
variable "logic_app_name" {}
variable "logic_app_service_plan_name" {}
variable "apappservice_tier" {}
variable "apappservice_size" {}
variable "function_app_name" {}
variable "functionapp_plan_name" {}
variable "fnappservice_tier" {}
variable "fnappservice_size" {}
variable "appservice_name" {}
variable "appservice_plan_name" {}
variable "waf_policy_name" {}
variable "app_gateway_name" {}
variable "ag_public_ip_name" {}
variable "privatelink_name" {}
variable "mysql_server_name" {}
variable "mysql_database_name" {}
variable "mysql_admin_login" {}
variable "mysql_admin_password" {}
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
variable "privateip1" {}
variable "privateip2" {}
  