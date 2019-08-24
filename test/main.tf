provider "aws" {
  profile          = "terraform"
  region           = "ca-central-1"
}

#Fot S3 state and Dynamodb state lock
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-bucket-mcdermg"
    key            = "dataart/instance/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

module "ec2" {
  source           = "../modules/ec2/"
}

#module "security-group" {
#  source           = "../modules/security-group/"
#  sshIP            = "181.46.138.37"
#}
