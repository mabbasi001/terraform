resource "azurecaf_name" "name" {
  name           = "${var.name}-linux"
  resource_types = ["azurerm_containerGroups"]
  suffixes       = [var.location, var.environment_code]
  random_length  = 4
  clean_input    = true
}

resource "azurerm_container_group" "cpce_container_group" {
  for_each = var.build_agents

  name                = "${azurecaf_name.name.results.azurerm_containerGroups}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private"
  subnet_ids          = [var.subnet_id]

  image_registry_credential {
    server   = var.acr_server
    username = var.acr_username
    password = var.acr_password
  }

  dynamic "container" {
    for_each = { for c in each.value : c.name => c }

    content {
      name                         = container.value.name
      image                        = container.value.image
      cpu                          = container.value.cpu
      memory                       = container.value.memory
      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables

      dynamic "ports" {
        for_each = container.value.port != null ? [container.value.port] : []

        content {
          port = ports.value
        }
      }
    }
  }
}
