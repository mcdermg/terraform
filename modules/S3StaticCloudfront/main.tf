resource "aws_s3_bucket" "logs" {
  bucket = "${var.site_name}-site-logs"
  acl    = "log-delivery-write"
}

data "template_file" "init" {
  template = "${file("bucket_policy.json")}"
  vars {
    origin_access_identity_arn = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    bucket = "${aws_s3_bucket.flask.arn}"
  }
}

resource "aws_s3_bucket" "flask" {
  bucket = "${var.site_name}"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
    target_prefix = "${var.site_name}/"
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "cloudfront origin access identity"
}

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled      = true
  price_class  = "PriceClass_100"
  http_version = "http1.1"
  aliases      = ["${var.site_name}"]

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.flask.id}"
    domain_name = "${var.site_name}.s3.${var.region}.amazonaws.com"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-bucket-${aws_s3_bucket.flask.id}"

    min_ttl     = "0"
    default_ttl = "300"  //3600
    max_ttl     = "1200" //86400

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.certificate_arn}"
    ssl_support_method  = "sni-only"
  }
}

resource "aws_route53_record" "site" {
  #zone_id = "${data.aws_route53_zone.site.zone_id}"
  #zone_id = "${aws_route53_zone.site.zone_id}"
  zone_id = "Z1QDQFJT6PX18I"
  name = "${var.site_name}"
  type = "A"
  alias {
    name = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    zone_id  = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}
