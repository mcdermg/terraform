variable "instance_type" {
    default = "t3.micro"
}
variable "key_name" {
    default = ""
}
variable "user_data" {
    default = ""
}

resource "aws_instance" "instance" {
  ami           = "${var.ami}"
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
