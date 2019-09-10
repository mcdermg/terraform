provider "aws" {
  profile          = "terraform"
  region           = "ca-central-1"
}

#Fot S3 state and Dynamodb state lock
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-bucket-mcdermg"
    key            = "dataart/flask1/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

module "S3StaticHosting" {
  source           = "../../../modules/s3StaticHosting/"
  # TODO review and remove if required
  bucket_name      = "dataart"
  # TODO review and remove if required
  name_length      = 2
}
