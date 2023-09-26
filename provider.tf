
provider "aws" {
  region     = var.the_region
  access_key = data.vault_generic_secret.secret.data["access_key"]
  secret_key = data.vault_generic_secret.secret.data["secret_key"]
}

provider "vault" {
  address = "https://vault-cluster-public-vault-98265e65.ea7c76de.z1.hashicorp.cloud:8200"
  token   = var.vault_token
}