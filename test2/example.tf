provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "random_id" "Tag_Name" {
  byte_length = 8
}

resource "aws_instance" "test1" {
  ami            = "${var.ami}"
  instance_type  = "${var.instance_type}"
  key_name       = "${var.key_name}"
  user_data      = "${var.user_data}"

  tags {
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
    Name  = "Terraform-${random_id.Tag_Name.hex}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.test1.public_ip} > ip_address.txt"
  }
}
