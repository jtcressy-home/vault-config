terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.8.0"
    }
  }
  required_version = ">=1.0"
}