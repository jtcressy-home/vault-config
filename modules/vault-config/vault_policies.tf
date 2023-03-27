locals {
  tailscale_secret_paths = [
    { path = "tailscale" },
    { path = "+/tailscale" },
    { path = "+/+/tailscale" },
    { path = "tailscale/*" },
  ]
}

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
  dynamic "rule" {
    for_each = local.tailscale_secret_paths
    content {
      path         = "generic/data/${rule.value.path}"
      capabilities = ["create", "read", "update", "list", "delete"]
    }
  }
  dynamic "rule" {
    for_each = local.tailscale_secret_paths
    content {
      path         = "generic/metadata/${rule.value.path}"
      capabilities = ["create", "read", "update", "list", "delete"]
    }
  }
  dynamic "rule" {
    for_each = local.tailscale_secret_paths
    content {
      path         = "generic/delete/${rule.value.path}"
      capabilities = ["update"]
    }
  }
}


resource "vault_policy" "tailscale_ro" {
  name   = "tailscale_ro"
  policy = data.vault_policy_document.tailscale_ro.hcl
}

data "vault_policy_document" "tailscale_ro" {
  dynamic "rule" {
    for_each = local.tailscale_secret_paths
    content {
      path         = "generic/data/${rule.value.path}"
      capabilities = ["read", "list"]
    }
  }
}


resource "vault_policy" "home-udm_rw" {
  name   = "home-udm_rw"
  policy = data.vault_policy_document.home-udm_rw.hcl
}

data "vault_policy_document" "home-udm_rw" {
  rule {
    path         = "generic/data/home-udm/*"
    capabilities = ["create", "read", "update", "delete", "list"]
  }
}


resource "vault_policy" "home-udm_ro" {
  name   = "home-udm_ro"
  policy = data.vault_policy_document.home-udm_ro.hcl
}

data "vault_policy_document" "home-udm_ro" {
  rule {
    path         = "generic/data/home-udm/*"
    capabilities = ["read", "list"]
  }
}
