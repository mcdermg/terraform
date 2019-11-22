provider "aws" {
  region  = "ca-central-1"
  version = "2.39.0"
  profile = "terraform"
}

module "vpc" {
  source = "vpc"
}
