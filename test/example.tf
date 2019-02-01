provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}


resource "aws_instance" "test1" {
  ami            = "${var.ami}"
  instance_type  = "${var.instance_type}"
  key_name       = "${var.key_name}"

  user_data = "${var.user_data}"

  tags {
    Name  = "Terraform",
    Stage = "Dev",
    Owner = "Gary Mc Dermott"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.test1.public_ip} > ip_address.txt"
  }
  depends_on = ["aws_s3_bucket.test1"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.test1.id}"
  depends_on = ["aws_instance.test1"]
}

resource "aws_s3_bucket" "test1" {
  bucket = "terraform-20190117"
  acl    = "private"
}
