provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

variable "profile" {
  default = "personal"
}

variable "region" {
  default = "ca-central-1"
}

variable "domain_name" {}

variable "validation_method" {}

resource "aws_acm_certificate" "cert" {
  domain_name               =  "${var.domain_name}"
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         =  "${var.validation_method}"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}
