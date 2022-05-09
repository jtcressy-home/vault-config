resource "google_storage_bucket" "vault" {
  name     = "vault-jtcressy-net"
  location = "global"
  lifecycle {
    prevent_destroy = true
  }
}