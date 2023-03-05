data "google_project" "current" {}

data "local_file" "vault-version" {
  filename = "${path.module}/../../.vault-version"
}