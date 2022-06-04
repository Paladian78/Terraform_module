variable "service_rg_name" {
  description = "variable for resource group name"
  type        = string
  default     = "services_resource_group"
}

variable "location" {
  default     = "eastasia"
  description = "Location for Resource Groups"
}

variable "vnet_rg_name" {
  default     = "vnet_resourge_group"
  description = "value for resorce_group_name"
}


variable "storage_account_name" {
  default     = "storageaccount0406"
  description = "value for storage_account_name"
}
