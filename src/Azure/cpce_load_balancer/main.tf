locals {
  name = var.name != null ? var.name : lower(format("lb%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
  frontend_name = "LoadBalancerIPConfig"
  backend_name  = "LoadBalancerBEAddressPool"
}

resource "azurerm_lb" "lb" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = local.name
  sku                 = var.sku_name
  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)

  frontend_ip_configuration {
    name                          = local.frontend_name
    zones                         = var.zones
    public_ip_address_id          = var.public_ip_address_id
    subnet_id                     = var.subnet_id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

# TODO: Add ability to have multiple backend address pools

resource "azurerm_lb_backend_address_pool" "backend" {
  name            = local.backend_name
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_nat_rule" "nat_rule" {
  for_each                       = var.nat_rules
  resource_group_name            = var.resource_group_name
  name                           = "rule-${each.key}"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.remote_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = local.frontend_name
}

resource "azurerm_lb_probe" "probe" {
  for_each            = var.lb_rules
  name                = "probe-${each.value.probe_port}"
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = each.value.probe_protocol
  port                = each.value.probe_port
  interval_in_seconds = 5
  number_of_probes    = 2
  request_path        = each.value.request_path
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = var.lb_rules
  name                           = each.key
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = local.frontend_name
  frontend_port                  = each.value.frontend_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend.id]
  backend_port                   = each.value.backend_port
  protocol                       = "Tcp"
  probe_id                       = lookup(azurerm_lb_probe.probe, each.key)["id"]
  enable_floating_ip             = false
  idle_timeout_in_minutes        = 5
}
