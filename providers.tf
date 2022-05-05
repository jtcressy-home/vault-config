provider "onepassword" {
  url = "http://localhost:8080"
}

data "onepassword_vault" "jtcressy-net-infra" {
  name = "jtcressy-net-infra"
}
