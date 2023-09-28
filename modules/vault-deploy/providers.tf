# provider "onepassword" {
#   url = "http://localhost:8080"
# }

# data "onepassword_vault" "jtcressy-net-infra" {
#   name = "jtcressy-net-infra"
# }

provider "google" {
  project = "jtcressy-net-235001"
  region  = "us-central1"
}

provider "google-beta" {
  project = "jtcressy-net-235001"
  region  = "us-central1"
}

# data "onepassword_item" "cloudflare-account" {
#   vault = data.onepassword_vault.jtcressy-net-infra.uuid
#   title = "cloudflare-account-id"
# }

# data "onepassword_item" "cloudflare-global" {
#   vault = data.onepassword_vault.jtcressy-net-infra.uuid
#   title = "cloudflare-global-api-key"
# }

# data "onepassword_item" "cloudflare-origin" {
#   vault = data.onepassword_vault.jtcressy-net-infra.uuid
#   title = "cloudflare-origin-api-key"
# }

