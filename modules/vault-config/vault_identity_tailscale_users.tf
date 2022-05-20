# This external group represents all devices belonging to a single user
# Each tailscale device will create an entity upon login and be assigned to this group if the username matches the alias below
resource "vault_identity_group" "tailscale_user_jtcressy" {
  name     = "tailscale_user_jtcressy"
  type     = "external"
  policies = ["default", vault_policy.admin-all.name]
}

resource "vault_identity_group_alias" "tailscale_user_jtcressy" {
  name           = "jtcressy-home.org.github:jtcressy@github"
  mount_accessor = vault_jwt_auth_backend.tailscale.accessor
  canonical_id   = vault_identity_group.tailscale_user_jtcressy.id
}