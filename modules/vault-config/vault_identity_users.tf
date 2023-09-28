resource "vault_identity_entity" "joel" {
  name     = "joel"
  policies = [vault_policy.admin-all.name]
}

resource "vault_identity_entity_alias" "joel" {
  name           = "joel@jtcressy.net"
  mount_accessor = vault_jwt_auth_backend.google-oidc.accessor
  canonical_id   = vault_identity_entity.joel.id
}