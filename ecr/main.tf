# ECR

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_ecr_repository" "ecr" {
  name = "${var.ecr_name}"
}
