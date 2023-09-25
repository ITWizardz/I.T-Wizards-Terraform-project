
provider "aws" {
  region     = var.the_region
  #access_key = data.vault_generic_secret.instance_key.data["access_key"]
  #secret_key = data.vault_generic_secret.instance_key.data["secret_key"]
  access_key = var.access_key
  secret_key = var.secret_key
}

