variable "resorce_group_name" {
  default = "azure-functions-test-rg"
  description = "value for resorce_group_name"
}
  
variable "location" {
    default = "eastasia"
    description = "value for location"
}

variable "app_service_plan_name" {
  default = "azure-functions-test-service-plan"
  description = "value for app_service_plan_name"
}

variable "storage_account_name" {
#   default = "value for storage_account_access_key"
  description = "value for storage_account_name"
}
  
variable "storage_account_access_key" {
#   default = "value for storage_account_access_key"
  description = "value for storage_account_access_key"
}