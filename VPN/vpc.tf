resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"

  tags {
    Name  = "Terraform",
    Stage = "Dev",
    Owner = "Gary Mc Dermott"
  }
}

resource "aws_security_group" "default" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name  = "Allow SSH",
  }
}
