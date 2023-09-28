import {
  id = "eba0c66d-6133-7751-f438-346122ac3e84"
  to = "vault_identity_entity.ghactions_vault-config_rw"
}

resource "vault_identity_entity" "ghactions_vault-config_rw" {
  name     = "ghactions_vault-config_rw"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.admin-all.name]
}


import{
  id = "5f4dc8aa-1826-70ea-b2f4-0018b5d5a133"
  to = "vault_identity_entity_alias.ghactions_vault-config_main"
}

resource "vault_identity_entity_alias" "ghactions_vault-config_main" {
  name           = "repo:jtcressy-home/vault-config:environment:vault-config"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_vault-config_rw.id
}

resource "vault_identity_entity_alias" "ghactions_vault-config_pull-request" {
  name           = "repo:jtcressy-home/vault-config:pull_request"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_vault-config_rw.id
}