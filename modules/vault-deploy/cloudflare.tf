resource "cloudflare_record" "jtcressy-net" {
  zone_id = data.cloudflare_zones.jtcressy-net.id
  name    = "vault"
  type    = "CNAME"
  value   = google_cloud_run_service.vault.status.0.url
  proxied = true
  ttl     = 1
}

resource "tls_private_key" "vault-cforigin-tls" {
  algorithm = "RSA"
}

resource "tls_cert_request" "vault-cforigin-tls" {
  private_key_pem = tls_private_key.vault-cforigin-tls.private_key_pem

  subject {
    common_name         = local.vault_external_fqdn
    organization        = "jtcressy-net"
    organizational_unit = "vault"
    country             = "US"
  }
}

resource "cloudflare_origin_ca_certificate" "vault-cforigin-tls" {
  csr = tls_cert_request.vault-cforigin-tls.cert_request_pem
  hostnames = [
    local.vault_external_fqdn,
  ]
  request_type       = "origin-rsa"
  requested_validity = 365
}

data "http" "cforigin-ca" {
  url = "https://developers.cloudflare.com/ssl/static/origin_ca_rsa_root.pem"
}
