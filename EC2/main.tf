provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_instance" "EC2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = "${var.security_groups}"

  tags {
    Name  = "Terraform"
    Stage = "Dev"
    Owner = "Gary Mc Dermott"
  }
}

resource "aws_eip" "EC2_public_IP" {
  instance   = "${aws_instance.EC2.id}"
  vpc        = true
  depends_on = ["aws_instance.EC2"]

  provisioner "local-exec" {
    command = "echo ${aws_eip.EC2_public_IP.public_ip} > pblic_ip_address.txt"
  }
}

output "EC2_public_IP" {
  value = "${aws_eip.EC2_public_IP.public_ip}"
}
