resource "azurerm_private_endpoint" "example" {
  name                = var.pren_name
  location            = var.location
  resource_group_name = var.service_rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.privateendpoint_name
    private_connection_resource_id = var.private_resource_id
    is_manual_connection           = false
    subresource_names = var.subresource_names
  }
}