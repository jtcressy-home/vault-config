# resource "vault_auth_backend" "approle" {
#   type = "approle"

#   tune {
#     default_lease_ttl  = "3600s"
#     listing_visibility = "hidden"
#     max_lease_ttl      = "604800s"
#   }
# }

# resource "vault_approle_auth_backend_role" "self" {
#   backend        = vault_auth_backend.approle.path
#   role_id        = data.onepassword_item.vault-self-approle.username
#   role_name      = "homelab-vault-terraform"
#   token_policies = ["default", "admin-all"]
# }

# resource "vault_approle_auth_backend_role_secret_id" "id" {
#   backend   = vault_auth_backend.approle.path
#   secret_id = data.onepassword_item.vault-self-approle.password
#   role_name = vault_approle_auth_backend_role.self.role_name
#   lifecycle {
#     create_before_destroy = true
#   }
# }
