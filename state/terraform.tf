#https://github.com/hashicorp/terraform/issues/18597
#need to comment this, run init, create resources then once created uncomment and
#re run init (try add -y to auto yes to copy existing state) and then oter TF can reference the S3 & Dunamo table 
terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-bucket-mcdermg"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
