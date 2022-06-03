variable "service_rg_name" {
  description = "variable for resource group name"
}

variable "location" {
  default     = "eastasia"
  description = "Location for Resource Groups"
}

variable "linux" {
  default     = "linux-vm-0306"
  description = "VM name"
}

variable "windows" {
  default     = "windows-vm-0306"
  description = "VM name"
}
