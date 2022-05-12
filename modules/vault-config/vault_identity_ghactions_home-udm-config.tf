resource "vault_identity_group" "ghactions_home-udm-config_rw" {
  name     = "ghactions_home-udm-config_rw"
  type     = "external"
  policies = ["default", vault_policy.home-udm_rw.name]
}

resource "vault_identity_group" "ghactions_home-udm-config_ro" {
  name     = "ghactions_home-udm-config_ro"
  type     = "external"
  policies = ["default", vault_policy.home-udm_ro.name]
}

resource "vault_identity_group_alias" "ghactions_home-udm-config_main" {
  name           = "repo:jtcressy-home/home-udm-config:ref:refs/heads/main"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_group.ghactions_home-udm-config_rw.id
}

resource "vault_identity_group_alias" "ghactions_home-udm-config_pull-request" {
  name           = "repo:jtcressy-home/home-udm-config:pull_request"
  mount_accessor = vault_jwt_auth_backend.jwt.accessor
  canonical_id   = vault_identity_group.ghactions_home-udm-config_ro.id
}