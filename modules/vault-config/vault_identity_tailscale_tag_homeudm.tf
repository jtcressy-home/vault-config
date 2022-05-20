# This external group represents all devices belonging to an ACL tag
# Each tailscale device will create an entity upon login and be assigned to this group if the tag matches the alias below
resource "vault_identity_group" "tailscale_tag_homeudm" {
  name     = "tailscale_tag_homeudm"
  type     = "external"
  policies = ["default", vault_policy.terraform-token.name, vault_policy.home-udm_rw.name]
}

resource "vault_identity_group_alias" "tailscale_tag_homeudm" {
  name           = "jtcressy-home.org.github:tag:homeudm"
  mount_accessor = vault_jwt_auth_backend.tailscale.accessor
  canonical_id   = vault_identity_group.tailscale_tag_homeudm.id
}