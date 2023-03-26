resource "vault_identity_entity" "ghactions_home-udm-config_rw" {
  name     = "ghactions_home-udm-config_rw"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.home-udm_rw.name]
}

resource "vault_identity_entity" "ghactions_home-udm-config_ro" {
  name     = "ghactions_home-udm-config_ro"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.home-udm_ro.name]
}

resource "vault_identity_entity_alias" "ghactions_home-udm-config_env-terraform" {
  name           = "repo:jtcressy-home/home-udm-config:environment:terraform"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_home-udm-config_rw.id
}

resource "vault_identity_entity_alias" "ghactions_home-udm-config_pull-request" {
  name           = "repo:jtcressy-home/home-udm-config:pull_request"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_home-udm-config_ro.id
}