provider "aws" {
  region  = "ca-central-1"
  version = "2.39.0"
  profile = "terraform"
}

data "aws_availability_zones" "zones" {}

module "vpc" {
  source             = "vpc"
  availability_zones = ["${data.aws_availability_zones.zones.names}"]
}

module "sg" {
  source = "sg"
  vpc_id = "${module.vpc.vpc_id}"
}
