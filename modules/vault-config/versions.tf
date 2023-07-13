terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
  }
  required_version = ">=1.0"
}