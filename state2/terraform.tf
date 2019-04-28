
terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-bucket-mcdermg"
    key    = "state2/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
