
resource "azurerm_firewall" "cpce_firewall" {
  name                = var.firewall.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall.sku_name
  sku_tier            = var.firewall.sku_tier
  firewall_policy_id  = var.firewall.firewall_policy_id

  ip_configuration {
    name                 = var.ip_configuration.name
    subnet_id            = var.ip_configuration.subnet_id
    public_ip_address_id = var.ip_configuration.public_ip_address_id
  }

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)
}