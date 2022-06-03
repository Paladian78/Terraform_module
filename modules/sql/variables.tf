variable "service_rg_name" {
  description = "variable for resource group name"
}

variable "location" {
  default     = "eastasia"
  description = "Location for Resource Groups"
}

variable "sec_grp" {
  description = "Security Group"
}

variable "sec_grp_id" {
  description = "Security Group ID"
}

variable "vnet_name" {
  description = "vnet name"
}

variable "username" {
  value       = ""
  description = "Your Azure Active Directory Username"
}

variable "object_id" {
  value       = ""
  description = "Object id"
}
