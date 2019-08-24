resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

variable "sshIP" {}

resource "aws_security_group" "securityGroup" {
  name        = "allow_SSH"
  description = "Allow inbound SSH, HTTP & HTTPS"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.sshIP}/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "securityGroup_id" {
  value = "${aws_security_group.securityGroup.id}"
}