resource "google_kms_key_ring" "vault-production" {
  name     = "vault-production"
  location = "global"
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "vault" {
  name            = "vault-key"
  key_ring        = google_kms_key_ring.vault-production.id
  rotation_period = "31536000s"
  lifecycle {
    prevent_destroy = true
  }
}
