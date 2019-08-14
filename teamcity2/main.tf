resource "random_pet" "name" {
}

resource "aws_instance" "teamcity" {
  ami = "${lookup(var.teamcity-images, var.region)}"

  instance_type = "t3.small"

  iam_instance_profile = "EC2_SSM_Profile"

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

  # TODO install docer pull containter start container
  user_data = "${var.user_data}"

  tags {
    Name  = "${var.Tag_Name}-${random_pet.name.id}"
    Owner = "${var.Tag_Owner}"
    AutoOff = "True"
  }
}

resource "aws_eip" "teamcity_eip" {
  instance   = "${aws_instance.teamcity.id}"
  vpc        = true
  depends_on = ["aws_instance.teamcity"]

}
