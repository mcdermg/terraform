resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow inbound SSH traffic BA IP"
  vpc_id      = "vpc-f4e4b092"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.18.32.109/32"]
  }

  tags {
    Name = "Allow SSH"
  }
}
