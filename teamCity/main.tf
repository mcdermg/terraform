#Teamcity Server

resource "random_pet" "name" {
  length = "2"
}

resource "aws_instance" "teamcity" {
  #ami                    = "${data.aws_ami.latest-ubuntu.id}"
  ami                    = "ami-0d0eaed20348a3389"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  iam_instance_profile   = "${var.iam_instance_profile}"
  vpc_security_group_ids = ["${aws_security_group.teamcity_security_group.id}"]

  #user_data = "${var.user_data}"

  lifecycle {
    ignore_changes = ["ami"]
  }
  tags {
    Name  = "Teamcity-${random_pet.name.id}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }

  #provisioner "remote-exec" {
  #  inline = ["echo 'Hello World!'"]

  #  connection {
  #    type        = "ssh"
  #    user        = "${var.ssh_user}"
  #    private_key = "${file("${var.private_key_path}")}"
  #  }
  #}

  #provisioner "local-exec" {
  #  command = "export ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' --private-key ${var.private_key_path} workstation.yml"
  #}
}

resource "aws_eip" "teamcity_eip" {
  instance   = "${aws_instance.teamcity.id}"
  vpc        = true
  depends_on = ["aws_instance.teamcity"]
}
