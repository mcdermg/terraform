module "aws_security_group" {
   source = "../security-group"
   sshIP            = "181.46.138.37"
}

variable "instance_type" {
    default = "t3.micro"
}
variable "key_name" {
    default = "teamcity2"
}
variable "user_data" {
    default = ""
}

data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_instance" "instance" {
  ami                     = "${data.aws_ami.latest-ubuntu.id}"
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${module.aws_security_group.securityGroup_id}"]
  iam_instance_profile    = "EC2_SSM"
  user_data               = "${var.user_data}"

  tags {
    Name                  = "Terraform"
    Stage                 = "Dev"
    Owner                 = "Gary Mc Dermott"
  }
}

resource "aws_eip" "ip" {
  instance                = "${aws_instance.instance.id}"
  depends_on               = ["aws_instance.instance"]
}
