provider "onepassword" {
  url = "http://localhost:8080"
}

data "onepassword_vault" "jtcressy-net-infra" {
  name = "jtcressy-net-infra"
}
// VAULT STUFF
/*
Vault Bootstrapping Guide
deploy vault, run "vault operator init" and save the output then grab the root_token.
supply this token (or a short-lived orphan token) via "-var=vault_bootstrap_token=<token>"
OR via "TF_VAR_vault_bootstrap_token=<token>" environment variable.
*/
data "onepassword_item" "vault-self-approle" {
  vault = data.onepassword_vault.jtcressy-net-infra.uuid
  title = "vault-self-approle"
}

provider "vault" {
  address          = "https://vault.jtcressy.net"
  skip_child_token = length(var.vault_bootstrap_token) > 0 ? false : true
  token            = var.vault_bootstrap_token
  dynamic "auth_login" {
    for_each = length(var.vault_bootstrap_token) > 0 ? [] : [{
      path = "auth/approle/login"
      parameters = {
        role_id   = data.onepassword_item.vault-self-approle.username
        secret_id = data.onepassword_item.vault-self-approle.password
      }
    }]
    //noinspection HILUnresolvedReference
    content {
      path       = auth_login.value.path
      parameters = auth_login.value.parameters
    }
  }
}