provider "aws" {
  profile = "labcli"
  region  = "ca-central-1"
}

resource "aws_s3_bucket" "terraform-lambda-201901" {
  bucket = "terraform-lambda-201901"
  acl    = "private"
}

