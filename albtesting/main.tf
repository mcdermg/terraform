resource "aws_instance" "report" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  count         = 1

  #user_data = "${var.user_data}"

  tags {
    Name  = "Terraform"
    Stage = "${var.environment}"
    Owner = "Gary Mc Dermott"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.report.public_ip} > ip_address.txt"
  }
}

resource "aws_alb" "ALB" {
  name            = "report-${var.environment}"
  security_groups = ["sg-0f1ab7290e16a5603"]
  subnets         = ["subnet-815b07fa", "subnet-993433f0"]

  tags {
    Name  = "Terraform"
    Stage = "${var.environment}"
    Owner = "Gary Mc Dermott"
  }
}

resource "null_resource" "alb_exists" {
  triggers {
    alb_name = "${aws_alb.ALB.id}"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.ALB.id}"
  port              = "80"
  protocol          = "HTTP"

  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.reporting.arn}"
  }
}

resource "aws_alb_target_group" "reporting" {
  name     = "report-${var.environment}"
  port     = 8080
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${var.vpc_id}"

  #depends_on = ["null_resource.alb.exists"]

  tags {
    Name  = "Terraform"
    Stage = "${var.environment}"
    Owner = "Gary Mc Dermott"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 300
    path                = "/"
    timeout             = 30
    unhealthy_threshold = 3
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = "${aws_alb_target_group.reporting.arn}"
  target_id        = "${aws_instance.report.id}"
  port             = 8080
}
