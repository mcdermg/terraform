variable "instance_type" {
    default = "t3.micro"
}
variable "key_name" {
    default = ""
}
variable "user_data" {
    default = ""
}

data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-18*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_instance" "instance" {
  ami           = "${data.aws_ami.latest-ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  user_data = "${var.user_data}"

  tags {
    Name  = "Terraform"
    Stage = "Dev"
    Owner = "Gary Mc Dermott"
  }
}

resource "aws_eip" "ip" {
  instance   = "${aws_instance.instance.id}"
  depends_on = ["aws_instance.instance"]
}
