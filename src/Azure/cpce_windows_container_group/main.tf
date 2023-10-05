resource "azurecaf_name" "name" {
  name           = "${var.name}-win"
  resource_types = ["azurerm_subnet", "azurerm_containerGroups", "azurerm_public_ip"]
  suffixes       = [var.location, var.environment_code]
  random_length  = 4
  clean_input    = true
}

resource "azurerm_container_group" "cpce_container_group" {
  for_each = { for a in var.build_agents : a.name => a }

  name                = "${azurecaf_name.name.results.azurerm_containerGroups}-${each.value.name}"
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Windows"
  restart_policy      = var.restart_policy
  ip_address_type     = "Private"
  subnet_ids          = [var.subnet_id]

  image_registry_credential {
    server   = var.acr_server
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name                         = each.value.name
    image                        = each.value.image
    cpu                          = each.value.cpu
    memory                       = each.value.memory
    environment_variables        = each.value.environment_variables
    secure_environment_variables = each.value.secure_environment_variables

    ports {
      port = each.value.port
    }
  }

  timeouts {
    create = "120m"
    update = "120m"
  }
}

