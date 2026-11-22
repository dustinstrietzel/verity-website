provider "aws" {
  region  = "us-east-1"
  profile = "verity-prod"

  default_tags {
    tags = {
      Project   = "verity-website"
      ManagedBy = "terraform"
    }
  }
}
