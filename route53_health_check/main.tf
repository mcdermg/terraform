resource "aws_route53_health_check" "demotestsite" {
  fqdn              = "demotestsite.net"
  port              = "${var.port}"
  type              = "${var.type}"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name        = "demotestsite.net-health-check"
    Origin      = "terraform"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
  }
}

resource "aws_route53_health_check" "garymcdermott" {
  fqdn              = "garymcdermott.net"
  port              = "${var.port}"
  type              = "${var.type}"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name        = "garymcdermott.net-health-check"
    Origin      = "terraform"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
  }
}

resource "aws_cloudwatch_metric_alarm" "demotestsite_alarm" {
  alarm_name                = "demotestsite-alarm-health-check"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "HealthCheckStatus"
  namespace                 = "AWS/Route53"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "1"
  insufficient_data_actions = []
  alarm_actions             = ["arn:aws:sns:us-east-1:949207431024:NotifyMe"]
  alarm_description         = "Send an alarm if ${var.environment} is down"

  dimensions {
    HealthCheckId = "${aws_route53_health_check.demotestsite.id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "garymcdermott_alarm" {
  alarm_name                = "garymcdermott-alarm-health-check"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "HealthCheckStatus"
  namespace                 = "AWS/Route53"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "1"
  insufficient_data_actions = []
  alarm_actions             = ["arn:aws:sns:us-east-1:949207431024:NotifyMe"]
  alarm_description         = "Send an alarm if ${var.environment} is down"

  dimensions {
    HealthCheckId = "${aws_route53_health_check.garymcdermott.id}"
  }
}
