data "cloudflare_ip_ranges" "current" {}
data "google_project" "current" {}

data "cloudflare_zones" "jtcressy-net" {
  filter {
    name = "jtcressy.net"
  }
}

data "local_file" "vault-version" {
  filename = "${path.module}/../../.vault-version"
}