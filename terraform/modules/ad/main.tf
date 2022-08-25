
data "azuread_domains" "aad_domains" {}
data "azuread_client_config" "current" {}

resource "azuread_user" "aks-user" {
  display_name        = var.aks-user-full-name
  password            = var.aks-user-password
  user_principal_name = "${var.aks-user-principal-name}@${data.azuread_domains.aad_domains.domains.*.domain_name[0]}"
}

resource "azuread_group" "aks-group" {
  display_name     = var.aks-group-name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  members = [
    azuread_user.aks-user.object_id,
      ]
}