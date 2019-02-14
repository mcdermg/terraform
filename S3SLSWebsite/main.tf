provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.bucket_1}"
  acl    = "log-delivery-write"

  tags {
    Name  =     "${var.Tag_Name}"
    Stage =     "${var.Tag_Stage}"
    Owner =     "${var.Tag_Owner}"
    Monitored = "${var.Tag_Monitored}"
  }
}

resource "aws_s3_bucket" "site" {
  bucket =  "${var.bucket_2}"
  acl    = "public-read"
  policy = "${file("policy.json")}"

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

  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "log/"
  }

  tags {
    Name  =     "${var.Tag_Name}"
    Stage =     "${var.Tag_Stage}"
    Owner =     "${var.Tag_Owner}"
    Monitored = "${var.Tag_Monitored}"
  }
  depends_on = ["aws_s3_bucket.log_bucket"]
}
