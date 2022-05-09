resource "google_secret_manager_secret" "vault-tls-cert" {
  secret_id = "vault-tls-cert"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "vault-tls-key" {
  secret_id = "vault-tls-key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vault-tls-cert" {
  secret      = google_secret_manager_secret.vault-tls-cert.name
  secret_data = cloudflare_origin_ca_certificate.vault-cforigin-tls.certificate
}

resource "google_secret_manager_secret_version" "vault-tls-key" {
  secret      = google_secret_manager_secret.vault-tls-key.name
  secret_data = tls_private_key.vault-cforigin-tls.private_key_pem
}

resource "google_secret_manager_secret_iam_member" "vault-tls-cert" {
  secret_id  = google_secret_manager_secret.vault-tls-cert.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.vault.email}"
  depends_on = [google_secret_manager_secret.vault-tls-cert]
}

resource "google_secret_manager_secret_iam_member" "vault-tls-key" {
  secret_id  = google_secret_manager_secret.vault-tls-key.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.vault.email}"
  depends_on = [google_secret_manager_secret.vault-tls-key]
}

resource "google_cloud_run_service" "vault" {
  name                       = "vault"
  location                   = local.location
  autogenerate_revision_name = true

  metadata {
    namespace = data.google_project.current.project_id
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = 1
        "run.googleapis.com/sandbox"       = "gvisor"
      }
    }
    spec {
      service_account_name  = google_service_account.vault.email
      container_concurrency = 80
      containers {
        image   = "us.gcr.io/${data.google_project.current.project_id}/vault:${chomp(data.local_file.vault-version.content)}"
        command = ["/usr/local/bin/docker-entrypoint.sh"]
        args    = ["server"]

        env {
          name  = "SKIP_SETCAP"
          value = "true"
        }

        env {
          name  = "VAULT_LOCAL_CONFIG"
          value = local.vault_config
        }

        env {
          name  = "VAULT_API_ADDR"
          value = "https://${local.vault_external_fqdn}"
        }

        resources {
          limits = {
            cpu    = "1000m"
            memory = "256Mi"
          }
          requests = {}
        }

        volume_mounts {
          name       = "tls-cert"
          mount_path = "/tls-cert"
        }
        volume_mounts {
          name       = "tls-key"
          mount_path = "/tls-key"
        }
      }
      volumes {
        name = "tls-cert"
        secret {
          secret_name  = google_secret_manager_secret.vault-tls-cert.secret_id
          default_mode = 292
          items {
            key  = "latest"
            path = "tls.crt"
            mode = 256
          }
        }
      }
      volumes {
        name = "tls-key"
        secret {
          secret_name  = google_secret_manager_secret.vault-tls-key.secret_id
          default_mode = 292
          items {
            key  = "latest"
            path = "tls.key"
            mode = 256
          }
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    members = ["allUsers"]
    role    = "roles/run.invoker"
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.vault.location
  project  = google_cloud_run_service.vault.project
  service  = google_cloud_run_service.vault.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "vault" {
  location = local.location
  name     = local.vault_external_fqdn

  metadata {
    namespace = data.google_project.current.project_id
  }

  spec {
    route_name = google_cloud_run_service.vault.name
  }
}