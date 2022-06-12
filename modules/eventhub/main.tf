resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.service_rg_name
  sku                 = var.eventhub_sku
  capacity            = 1
}

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.service_rg_name
  partition_count     = 2
  message_retention   = 1
}
