#Display outputs. Also saving these to file via local-exec in main.tf
output "Wordpress_Public_IP" {
  value = "${aws_eip.wordpress_eip.public_ip}"
}

output "Wordpress_DNS" {
  value = "${aws_instance.wordpress.public_dns}"
}

output "Wordpress_EC2_IP" {
  value = "${aws_instance.wordpress.public_ip}"
}
