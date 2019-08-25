resource "aws_s3_bucket" "logs" {
  bucket = "${var.site_name}-site-logs"
  acl = "log-delivery-write"
}

resource "aws_s3_bucket" "www_site" {
  bucket = "www.${var.site_name}"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
    target_prefix = "www.${var.site_name}/"
  }

  website {
    index_document = "index.html"
  }
}
