terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.20.1"
    }
  }
  required_version = ">=1.0"
}