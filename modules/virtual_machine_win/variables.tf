variable "service_rg_name" {
  description = "variable for resource group name"
}

variable "location" {
  default     = "eastasia"
  description = "Location for Resource Groups"
}

variable "windows" {
  default     = "windows-vm-0306"
  description = "VM name"
}

variable "vnet_name" {
  description = "vnet name"
}

variable "vnet_rg_name" {
  description = "value for resorce_group_name"
}

