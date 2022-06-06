# Managed Instance
# resource "azurerm_network_security_rule" "allow_management_inbound" {
#   name                        = "allow_management_inbound"
#   priority                    = 106
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "allow_misubnet_inbound" {
#   name                        = "allow_misubnet_inbound"
#   priority                    = 200
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "10.0.0.0/24"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
#   name                        = "allow_health_probe_inbound"
#   priority                    = 300
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "AzureLoadBalancer"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "allow_tds_inbound" {
#   name                        = "allow_tds_inbound"
#   priority                    = 1000
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "1433"
#   source_address_prefix       = "VirtualNetwork"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "deny_all_inbound" {
#   name                        = "deny_all_inbound"
#   priority                    = 4096
#   direction                   = "Inbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "allow_management_outbound" {
#   name                        = "allow_management_outbound"
#   priority                    = 102
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_ranges     = ["80", "443", "12000"]
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
#   name                        = "allow_misubnet_outbound"
#   priority                    = 200
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "10.0.0.0/24"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_network_security_rule" "deny_all_outbound" {
#   name                        = "deny_all_outbound"
#   priority                    = 4096
#   direction                   = "Outbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.service_rg_name
#   network_security_group_name = var.sec_grp
# }

# resource "azurerm_subnet" "sql_subnet" {
#   name                 = "subnet-sql"
#   resource_group_name  = var.service_rg_name
#   virtual_network_name = var.vnet_name
#   address_prefixes     = ["10.0.0.0/24"]

#   delegation {
#     name = "managedinstancedelegation"

#     service_delegation {
#       name    = "Microsoft.Sql/managedInstances"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
#     }
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "nsg_associat" {
#   subnet_id                 = azurerm_subnet.sql_subnet.id
#   network_security_group_id = var.sec_grp_id
# }

# resource "azurerm_route_table" "route_table" {
#   name                          = "routetable-sql"
#   location                      = var.location
#   resource_group_name           = var.service_rg_name
#   disable_bgp_route_propagation = false
#   depends_on = [
#     azurerm_subnet.sql_subnet,
#   ]
# }

# resource "azurerm_subnet_route_table_association" "rr_associate" {
#   subnet_id      = azurerm_subnet.sql_subnet.id
#   route_table_id = azurerm_route_table.route_table.id
# }

# resource "azurerm_mssql_managed_instance" "sql_instance" {
#   name                = "managedsqlinstance"
#   resource_group_name = var.service_rg_name
#   location            = var.location

#   license_type       = "BasePrice"
#   sku_name           = "GP_Gen5"
#   storage_size_in_gb = 32
#   subnet_id          = azurerm_subnet.sql_subnet.id
#   vcores             = 0

#   administrator_login          = "mradministrator"
#   administrator_login_password = "thisIsDog11"

#   depends_on = [
#     azurerm_subnet_network_security_group_association.nsg_associat,
#     azurerm_subnet_route_table_association.rr_associate,
#   ]
# }


# Server
resource "azurerm_mssql_server" "server" {
  name                         = var.mysql_server_name
  resource_group_name          = var.service_rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.mysql_admin_login
  administrator_login_password = var.mysql_admin_password
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = var.username
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
