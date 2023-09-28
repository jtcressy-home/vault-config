variable "vault_bootstrap_token" {
  default   = ""
  sensitive = true
}

provider vault {}

module "vault-config" {
  source                = "../../modules/vault-config"
  vault_bootstrap_token = var.vault_bootstrap_token
  providers = {
    vault = vault
  }
}

import {
  id = "eba0c66d-6133-7751-f438-346122ac3e84"
  to = module.vault-config.vault_identity_entity.ghactions_vault-config_rw
}

import{
  id = "5f4dc8aa-1826-70ea-b2f4-0018b5d5a133"
  to = module.vault-config.vault_identity_entity_alias.ghactions_vault-config_main
}