resource "random_pet" "name" {}

resource "aws_instance" "teamcity" {
  ami = "${lookup(var.teamcity-images, var.region)}"

  instance_type = "t3.small"

  iam_instance_profile = "EC2_SSM"

  vpc_security_group_ids = [
    "${aws_security_group.teamcity_security_group.id}",
  ]

  availability_zone = "${lookup(var.zones, var.region)}"

  key_name = "teamcity2"

  associate_public_ip_address = true

  root_block_device = {
    "volume_type"           = "standard"
    "volume_size"           = 40
    "delete_on_termination" = false
  }

  tags {
    Name    = "${var.Tag_Name}-${random_pet.name.id}"
    Owner   = "${var.Tag_Owner}"
    AutoOff = "True"
  }
  provisioner "remote-exec" {
    inline = ["echo 'Instance now contatable via ssh'"]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file("${var.private_key_path}")}"
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip}' --private-key ${var.private_key_path} ./roles/customization/tasks/main.yml"
  }
}

resource "aws_eip" "teamcity_eip" {
  instance   = "${aws_instance.teamcity.id}"
  vpc        = true
  depends_on = ["aws_instance.teamcity"]
}

resource "aws_security_group" "teamcity_security_group" {
  name        = "teamcity_security_group-${random_pet.name.id}"
  description = "control access to teamcity server"

  tags {
    Owner = "${var.Tag_Owner}"
  }
}

resource "aws_security_group_rule" "ingress_http" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_https" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_reply" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_reply" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_ssh" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.local_IP}/32"]
  description       = "SSH access for server management"
}

resource "aws_security_group_rule" "ingress_all" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${var.local_IP}/32"]
  description       = "Office access"
}
