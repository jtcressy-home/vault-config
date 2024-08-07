terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
  required_version = ">=1.0"
}