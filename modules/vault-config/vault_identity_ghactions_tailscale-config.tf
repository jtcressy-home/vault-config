resource "vault_identity_entity" "ghactions_tailnet-config_rw" {
  name     = "ghactions_tailnet-config_rw"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.tailscale_rw.name]
}

resource "vault_identity_entity" "ghactions_tailnet-config_ro" {
  name     = "ghactions_tailnet-config_ro"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.tailscale_ro.name]
}

resource "vault_identity_entity_alias" "ghactions_tailnet-config_main" {
  name           = "repo:jtcressy-home/tailnet-config:ref:refs/heads/main"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_tailnet-config_rw.id
}

resource "vault_identity_entity_alias" "ghactions_tailnet-config_pull-request" {
  name           = "repo:jtcressy-home/tailnet-config:pull_request"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_entity.ghactions_tailnet-config_ro.id
}