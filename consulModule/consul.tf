provider "aws" {
  access_key = "AWS ACCESS KEY"
  secret_key = "AWS SECRET KEY"
  region     = "ca-central-1"
}

module "consul" {
  source = "hashicorp/consul/aws"

  #aws_region  = "ca-central-1" # should match provider region
  num_servers = "3"
}
