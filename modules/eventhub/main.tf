resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "eventhub-namespace-test"
  location            = var.location
  resource_group_name = var.service_rg_name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "eventhub" {
  name                = "eventhub-test"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.service_rg_name
  partition_count     = 2
  message_retention   = 1
}
