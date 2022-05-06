terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.1.4"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.5.0"
    }
  }
  required_version = ">=1.0"
}