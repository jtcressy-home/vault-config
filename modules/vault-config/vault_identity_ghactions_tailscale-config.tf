resource "vault_identity_group" "ghactions_tailscale-config_rw" {
  name     = "ghactions_tailscale-config_rw"
  type     = "external"
  policies = ["default", vault_policy.tailscale_rw.name]
}

resource "vault_identity_group" "ghactions_tailscale-config_ro" {
  name     = "ghactions_tailscale-config_ro"
  type     = "external"
  policies = ["default"]
}

resource "vault_identity_group_alias" "ghactions_tailscale-config_main" {
  name           = "repo:jtcressy-home/tailscale-config:ref:refs/heads/main"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_group.ghactions_tailscale-config_rw.id
}

resource "vault_identity_group_alias" "ghactions_tailscale-config_pull-request" {
  name           = "repo:jtcressy-home/tailscale-config:pull_request"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_group.ghactions_tailscale-config_ro.id
}