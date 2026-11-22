terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "verity-tfstate-895002944355"
    key          = "website/terraform.tfstate"
    region       = "us-east-1"
    profile      = "verity-prod"
    encrypt      = true
    use_lockfile = true
  }
}