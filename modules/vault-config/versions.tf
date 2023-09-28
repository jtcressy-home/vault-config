terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.20.1"
    }
  }
  required_version = ">=1.0"
}