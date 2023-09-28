terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "1.2.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>4.20"
    }
    google = {
      source  = "hashicorp/google"
      version = "~>4.20"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.15.0"
    }
  }
  required_version = ">=1.0"
}