#Teamcity Server

data "aws_ami" "latest-ubuntu" {
  most_recent = true

  #  filter {
  #    name   = "name"
  #    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  #  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "random_pet" "name" {
  length = "2"
}

resource "aws_instance" "teamcity" {
  ami                    = "${data.aws_ami.latest-ubuntu.id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.teamcity_security_group.id}"]
  user_data              = "${var.user_data}"

  lifecycle {
    ignore_changes = ["ami"]
  }

  tags {
    Name  = "Teamcity-${random_pet.name.id}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }

  #  provisioner "local-exec" {
  #    command = "echo EC2_IP : ${aws_instance.teamcity.public_ip}> serverDetails.txt"
  #    command = "echo EC2_DNS: ${aws_instance.teamcity.public_dns}>> serverDetails.txt"
  #  }
}

resource "aws_eip" "teamcity_eip" {
  instance   = "${aws_instance.teamcity.id}"
  vpc        = true
  depends_on = ["aws_instance.teamcity"]

  provisioner "local-exec" {
    command = "echo EIP_IP : ${aws_eip.teamcity_eip.public_ip}>> serverDetails.txt"
  }
}
