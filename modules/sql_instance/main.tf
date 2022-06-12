resource "azurerm_mssql_managed_instance" "mssql_managed_instance" {
  name                         = var.sql_managed_instance_name
  resource_group_name          = var.service_rg_name
  location                     = var.location
  administrator_login          = var.sqlinst_admin
  administrator_login_password = var.sqlinst_admin_pass
  license_type                 = "BasePrice"
  subnet_id                    = var.subnet_id
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32
}

data "azurerm_client_config" "current" {}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "mssql_managed_instance_ad" {
  managed_instance_id   = azurerm_mssql_managed_instance.mssql_managed_instance.id
  login_username        =  "sqladmin"
  tenant_id             = data.azurerm_client_config.current.tenant_id
  object_id             = var.object_id
}