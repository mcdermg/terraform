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

resource "aws_security_group" "rds_sg" {
  name        = "TeamCity_rds_sg"
  description = "TeamCity RDS Security Group"
  vpc_id      = "${var.vpc_id}"
  depends_on  = ["aws_security_group.teamcity_web_sg"]

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["aws_security_group.teamcity_web_sg.id"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "TeamCity RDS Security Group"
  }
}
