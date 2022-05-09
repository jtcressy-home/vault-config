locals {
  location            = "us-central1"
  vault_external_fqdn = "vault.jtcressy.net"
  vault_config = jsonencode({
    storage = {
      gcs = {
        bucket = "vault-jtcressy-net"
      }
    }
    seal = {
      gcpckms = {
        project    = data.google_project.current.project_id
        region     = "global"
        key_ring   = google_kms_key_ring.vault-production.name
        crypto_key = google_kms_crypto_key.vault.name
      }
    }
    default_lease_ttl = "168h"
    max_lease_ttl     = "720h"
    disable_mlock     = true
    listener = {
      tcp = {
        address         = "0.0.0.0:8080"
        tls_disable     = 1
        # tls_cert_file   = "/tls-cert/tls.crt"
        # tls_key_file    = "/tls-key/tls.key"
        # tls_min_version = "tls13"
      }
    }
    ui         = true
    log_level  = "ERROR"
    log_format = "json"
  })
}
