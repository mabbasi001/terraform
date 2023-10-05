locals {
  display_name = length(regexall(" ", var.display_name)) > 0 ? title(var.display_name) : var.display_name
}

resource "azuread_user" "cpce_aad_user" {
  user_principal_name = var.user_principal_name
  display_name        = local.display_name
  password            = var.password
}
