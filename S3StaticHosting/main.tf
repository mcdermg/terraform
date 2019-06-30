#Created by Gary Mc Dermott 2019-05-26 for static website hosting

resource "random_pet" "bucket" {
  length = "${var.name_length}"
}

data "template_file" "S3hosting" {
  template = "${file("policy.json.tpl")}"

  vars {
    resource = "${aws_s3_bucket.mkdocs.arn}"
  }
}

resource "aws_s3_bucket" "mkdocs" {
  bucket = "${var.bucket_name}-${random_pet.bucket.id}"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  #  policy = <<EOF
  #{
  #  "Id": "bucket_policy_site",
  #  "Version": "2012-10-17",
  #  "Statement": [
  #    {
  #      "Sid": "bucket_policy_site_main",
  #      "Action": [
  #        "s3:GetObject"
  #      ],
  #      "Effect": "Allow",
  #      "Resource": "arn:aws:s3:::${var.bucket_name}/*",
  #      "Principal": "*"
  #    }
  #  ]
  #}
  #EOF

  website {
    index_document = "index.html"
    error_document = "404.html"

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
  value = "${var.bucket_name}-${random_pet.bucket.id}"
}
