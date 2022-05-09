resource "google_storage_bucket" "vault" {
  name     = "vault-jtcressy-net"
  location = "US"
  lifecycle {
    prevent_destroy = true
  }
}