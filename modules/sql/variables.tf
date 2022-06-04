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

# Provide your azure active directories username and object id
variable "username" {
  default     = "Mohammad Amaan Khan"
  description = "Your Azure Active Directory Username"
}

variable "object_id" {
  default     = "cb982425-08e2-4842-ae76-e1a96116e38a"
  description = "Object id"
}
