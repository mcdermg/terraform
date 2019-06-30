resource "aws_route53_health_check" "example" {
  fqdn              = "${var.fqdn}"
  port              = "${var.port}"
  type              = "${var.type}"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "tf-test-health-check"
  }
}

#module "state" {
#  source = "../state"
#}

