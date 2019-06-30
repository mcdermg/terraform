resource "aws_route53_health_check" "demotestsite" {
  fqdn              = "${var.fqdn}"
  port              = "${var.port}"
  type              = "${var.type}"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "demotestsite.net-health-check"
  }
}

#resource "aws_route53_health_check" "demotestsite" {
#  fqdn              = "${var.fqdn}"
#  port              = "${var.port}"
#  type              = "${var.type}"
#  resource_path     = "/"
#  failure_threshold = "5"
#  request_interval  = "30"
#
#  tags = {
#    Name = "garymcdermott.net-health-check"
#  }
#}

