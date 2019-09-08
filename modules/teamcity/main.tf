#Teamcity Server

resource "random_pet" "name" {
  length = "2"
}

module "securityGroup" {
  source = "../security-group/"
}

resource "aws_instance" "teamcity" {
  ami                     = "${data.aws_ami.latest.id}"
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"
  iam_instance_profile    = "${var.iam_instance_profile}"
  vpc_security_group_ids  = ["${module.securityGroup.securityGroup_id}"]
  user_data               = "${var.user_data}"

  lifecycle {
    ignore_changes  = ["ami"]
  }

  tags {
    Name  = "Teamcity-${random_pet.name.id}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["591542846629"] # Amazon

  filter {
    name      = "name"
    values    = ["amzn2-ami-ecs-hvm-2.0*"]
  }

  filter {
    name      = "virtualization-type"
    values    = ["hvm"]
  }
}

resource "aws_eip" "teamcity_eip" {
  instance   = "${aws_instance.teamcity.id}"
  vpc        = true
  depends_on = ["aws_instance.teamcity"]
}
