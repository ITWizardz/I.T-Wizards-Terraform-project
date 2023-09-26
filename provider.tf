
provider "aws" {
  region     = var.the_region
  access_key = data.vault_generic_secret.secret.data["access_key"]
  secret_key = data.vault_generic_secret.secret.data["secret_key"]
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}