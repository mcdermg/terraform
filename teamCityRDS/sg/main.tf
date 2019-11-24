variable "vpc_id" {
  type        = "string"
  description = "VPC ID in which to deploy RDS"
}

resource "aws_security_group" "teamcity_web_sg" {
  name        = "TeamCity Web"
  description = "Allow TeamCity SSH & HTTP inbound connections"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["181.46.138.37/32"]
    description = "ssh access from home"
  }

  ingress {
    from_port   = 8111
    to_port     = 8111
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "TeamCity Web Security Group"
  }
}
