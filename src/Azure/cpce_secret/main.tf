locals {
  encryption_is_em = var.encryption_type == "environment_manager"
  encryption_is_ec = var.encryption_type == "encipherment_certificate"
}

# locate keyvault
data "azurerm_key_vault" "environment_keyvault" {
  name                = var.environment_keyvault
  resource_group_name = var.environment_keyvault_resource_group
}

# secret owned by this template
# created once
resource "azurerm_key_vault_secret" "secret" {
  count        = var.secret_is_managed_resource ? 1 : 0
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.environment_keyvault.id
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

data "azurerm_key_vault_secret" "secret" {
  count        = var.secret_is_managed_resource ? 0 : 1
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.environment_keyvault.id
}

# encipherment certificate(ec) encrypted certificate
data "external" "encrypted_secret" {
  count = local.encryption_is_ec ? 1 : 0
  program = [
    "pwsh.exe",
    "-Command",
    var.cpcedataenciphermentcertificatepath != null ? "$null=import-module ServiceFabric -SkipEditionCheck;@{encrypted_value=(Invoke-ServiceFabricEncryptText -Text '${var.secret_value == null ? data.azurerm_key_vault_secret.secret[0].value : azurerm_key_vault_secret.secret[0].value}' -CertFile -Path ${var.cpcedataenciphermentcertificatepath})}|ConvertTo-Json" : "$null=import-module ServiceFabric -SkipEditionCheck;@{encrypted_value=(Invoke-ServiceFabricEncryptText -CertStore -CertThumbprint '${var.certificate_thumbprint}' -Text '${var.secret_value == null ? data.azurerm_key_vault_secret.secret[0].value : azurerm_key_vault_secret.secret[0].value}' -StoreLocation LocalMachine -StoreName My)}|ConvertTo-Json"
  ]
  lifecycle {
    precondition {
      condition     = var.cpcedataenciphermentcertificatepath != null || var.certificate_thumbprint != null
      error_message = "Encipherment certificate or thumbprint must be provided when encryption type is \"encipherment_certificate\"."
    }
  }
}

data "external" "firstfivecharthumbprint" {
  count = var.cpcedataenciphermentcertificatepath != null ? 1 : 0
  program = [
    "pwsh.exe",
    "-Command",
    "@{value=(New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 '${var.cpcedataenciphermentcertificatepath}').Thumbprint.substring(0,5)}|ConvertTo-Json"
  ]
}

# environment manager(em) encrypted certificate
data "external" "encrypted_secret_environment_manager" {
  count = local.encryption_is_em ? 1 : 0
  program = [
    "pwsh.exe",
    "-Command",
    "$null=[Reflection.Assembly]::LoadFile(\"${abspath(path.module)}/tooling/Cpce.StringCipher.dll\");@{encrypted_value=[Cpce.StringCipher.StringCipher]::Encrypt(\"${var.secret_value == null ? data.azurerm_key_vault_secret.secret[0].value : azurerm_key_vault_secret.secret[0].value}\")}|ConvertTo-Json"
  ]
}

# value is either new encrypted value, or existing value
resource "azurerm_key_vault_secret" "secret_encrypted" {
  count        = local.encryption_is_ec ? 1 : 0
  name         = "${var.secret_name}-ec-${var.secret_value == null ? split("/",data.azurerm_key_vault_secret.secret[0].id)[length(split("/",data.azurerm_key_vault_secret.secret[0].id))-1] : azurerm_key_vault_secret.secret[0].version}-${var.certificate_thumbprint != null ? substr(var.certificate_thumbprint, 0, 5) : data.external.firstfivecharthumbprint[0].result.value}"
  value        = data.external.encrypted_secret[0].result.encrypted_value
  key_vault_id = data.azurerm_key_vault.environment_keyvault.id
  lifecycle {
    ignore_changes = [
      # Ignore the value change
      # So until a *new* version of raw secret exists, the encrypted value will stay the same.
      value
    ]
  }
}


# value is either new encrypted value, or existing value
resource "azurerm_key_vault_secret" "secret_encrypted_environment_manager" {
  count        = local.encryption_is_em ? 1 : 0
  name         = "${var.secret_name}-em-${var.secret_value == null ? data.azurerm_key_vault_secret.secret[0].version : azurerm_key_vault_secret.secret[0].version}"
  value        = data.external.encrypted_secret_environment_manager[0].result.encrypted_value
  key_vault_id = data.azurerm_key_vault.environment_keyvault.id
  lifecycle {
    ignore_changes = [
      # Ignore the value change
      # So until a *new* version of raw secret exists, the encrypted value will stay the same.
      value
    ]
  }
}
