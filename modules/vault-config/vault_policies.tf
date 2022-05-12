resource "vault_policy" "admin-all" {
  name   = "admin-all"
  policy = data.vault_policy_document.admin-all.hcl
}

data "vault_policy_document" "admin-all" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  }
}


resource "vault_policy" "terraform-token" {
  name   = "terraform-token"
  policy = data.vault_policy_document.terraform-token.hcl
}

data "vault_policy_document" "terraform-token" {
  rule {
    path         = "auth/token/create"
    capabilities = ["create", "update"]
  }
}


resource "vault_policy" "tailscale_rw" {
  name   = "tailscale_rw"
  policy = data.vault_policy_document.tailscale_rw.hcl
}

data "vault_policy_document" "tailscale_rw" {
  rule {
    path         = "*tailscale*"
    capabilities = ["create", "read", "update", "delete", "list"]
  }
}


resource "vault_policy" "home-udm_rw" {
  name   = "home-udm_rw"
  policy = data.vault_policy_document.home-udm_rw.hcl
}

data "vault_policy_document" "home-udm_rw" {
  rule {
    path         = "generic/home-udm/*"
    capabilities = ["create", "read", "update", "delete", "list"]
  }
}


resource "vault_policy" "home-udm_ro" {
  name   = "home-udm_ro"
  policy = data.vault_policy_document.home-udm_ro.hcl
}

data "vault_policy_document" "home-udm_ro" {
  rule {
    path         = "generic/home-udm/*"
    capabilities = ["read", "list"]
  }
}
