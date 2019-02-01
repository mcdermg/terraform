resource "aws_instance" "example" {
  ami            = "${lookup(var.amis, var.region)}"
  instance_type  = "${var.instance_type}"
  key_name       = "${var.key_name}"

  #user_data = "${var.user_data}"

  tags {
    Name  = "Terraform",
    Stage = "Dev",
    Owner = "Gary Mc Dermott"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

output "amis" {
  value = "${lookup(var.amis, var.region)}"
}
output "ip" {
  value = "${aws_instance.example.public_ip}"
}
