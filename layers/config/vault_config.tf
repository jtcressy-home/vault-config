variable "vault_bootstrap_token" {
  default   = ""
  sensitive = true
}

module "vault-config" {
  source                = "../../modules/vault-config"
  vault_bootstrap_token = var.vault_bootstrap_token
}