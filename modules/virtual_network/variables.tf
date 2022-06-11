variable "vnet_name" {}
variable "service_rg_name" {}
variable "location" {}
variable "virtual_network_address" {
  type = list(string)
}
variable "subnet_frontend_address" {
  type = list(string)
}
variable "subnet_backend_address" {
  type = list(string)
}
