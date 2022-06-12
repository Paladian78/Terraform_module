variable "vnet_name" {
  type = string
}
variable "service_rg_name" {
  type = string
}
variable "location" {
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

