resource "azurerm_mssql_server" "server" {
  name                         = var.mysql_server_name
  resource_group_name          = var.service_rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.mysql_admin_login
  administrator_login_password = var.mysql_admin_password
  minimum_tls_version          = "1.2"
  azuread_administrator {
    login_username = var.mysql_admin_username
    object_id      = var.object_id
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.mysql_database_name
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "Basic"
  zone_redundant = false
}
