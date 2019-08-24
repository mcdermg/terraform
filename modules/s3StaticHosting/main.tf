resource "random_pet" "suffix" {
  length = "${var.name_length}"
}

variable "name_length" {}

variable "bucket_name" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${random_pet.suffix.id}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
     "Sid":"PublicReadGetObject",
     "Effect":"Allow",
     "Principal": "*",
     "Action":["s3:GetObject"],
     "Resource":["arn:aws:s3:::mkdocs-casual-urchin/*"]
  }]
}
EOF
  
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

output "bucket_name" {
  value = "${var.bucket_name}-${random_pet.suffix.id}"
}
