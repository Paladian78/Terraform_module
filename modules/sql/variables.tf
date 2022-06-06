variable "service_rg_name" {}
variable "location" {}
variable "sec_grp" {}
variable "sec_grp_id" {}
variable "vnet_name" {}
variable "mysql_admin_login" {}
variable "mysql_admin_password" {}
variable "mysql_server_name" {}
variable "mysql_database_name" {}

# Provide your azure active directories username and object id
variable "username" {
  default     = "Mohammad Amaan Khan"
  description = "Your Azure Active Directory Username"
}

variable "object_id" {
  default     = "cb982425-08e2-4842-ae76-e1a96116e38a"
  description = "Object id"
}
