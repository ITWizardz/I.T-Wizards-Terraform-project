terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  cloud {
    organization = "WMCA-2023"

    workspaces {
      name = "learn-terraform-github-aws"
    }
  }
}
