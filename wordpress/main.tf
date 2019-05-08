#Wordpress server
resource "aws_instance" "wordpress" {
  ami = "${lookup(var.wordpress-images, var.region)}"

  instance_type = "t2.micro"

  security_groups = [
    "${aws_security_group.wordpress_security_group.name}",
  ]

  availability_zone = "${lookup(var.zones, var.region)}"

  key_name = "awswordpress1"

  associate_public_ip_address = true

  root_block_device = {
    "volume_type"           = "standard"
    "volume_size"           = 40
    "delete_on_termination" = false
  }

  user_data = "${var.user_data}"

  tags {
    Name  = "${var.Tag_Name}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }

  provisioner "local-exec" {
    command = "echo EC2_IP : ${aws_instance.wordpress.public_ip}> serverDetails.txt"
    command = "echo EC2_DNS: ${aws_instance.wordpress.public_dns}>> serverDetails.txt"
  }
}

resource "aws_eip" "wordpress_eip" {
  instance   = "${aws_instance.wordpress.id}"
  vpc        = false
  depends_on = ["aws_instance.wordpress"]

  provisioner "local-exec" {
    command = "echo EIP_IP : ${aws_eip.wordpress_eip.public_ip}>> serverDetails.txt"
  }
}
