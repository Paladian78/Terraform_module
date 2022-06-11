resource "azurerm_frontdoor" "frontdoor" {
  name                = var.frontdoor_name
  resource_group_name = var.service_rg_name

  routing_rule {
    name               = "frontdoorRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontdoormysssaa"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "frontdoorBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "frontdoorLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "frontdoorHealthProbeSetting1"
  }

  backend_pool {
    name = "frontdoorBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "frontdoorLoadBalancingSettings1"
    health_probe_name   = "frontdoorHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "frontdoormysssaa"
    host_name = "frontdoormysssaa.azurefd.net"
  }
}