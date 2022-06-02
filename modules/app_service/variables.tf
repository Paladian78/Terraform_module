variable "prefix" {
  description = "prefix befor every resource name"
}

variable "location" {
  description = "Location you want to deploy your app"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "myfrst-resources"
}