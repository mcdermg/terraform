#Fot S3 state and Dynamodb state lock
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-bucket-mcdermg"
    key            = "security-group/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
