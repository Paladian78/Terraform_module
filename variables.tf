variable "service_rg_name" {
  description = "variable for resource group name"
  type        = string
  default     = "services_resource_group"
}

variable "location" {
  default     = "eastasia"
  description = "Location for Resource Groups"
}

# variable "resource_group_name" {
#   default     = "azure-functions-test-rg"
#   description = "value for resorce_group_name"
# }


variable "storage_account_name" {
  default     = "storageaccount0406"
  description = "value for storage_account_name"
}
