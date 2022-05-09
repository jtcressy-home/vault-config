resource "google_service_account" "vault" {
  account_id   = "vault-sa"
  display_name = "Vault Service Account for KMS auto-unseal"
}

resource "google_storage_bucket_iam_member" "vault" {
  bucket = google_storage_bucket.vault.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.vault.email}"
}

resource "google_kms_key_ring_iam_member" "vault" {
  key_ring_id = google_kms_key_ring.vault-production.id
  role        = "roles/owner"
  member      = "serviceAccount:${google_service_account.vault.email}"
}



