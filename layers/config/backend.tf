terraform {
  backend "gcs" {
    bucket = "terraform-state-jtcressy-net"
    prefix = "home/vault-config"
  }
}