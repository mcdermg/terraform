#Display outputs. Also saving these to file via local-exec in main.tf
output "teamcity_Public_IP" {
  value = "${aws_eip.teamcity_eip.public_ip}"
}

#output "Teamcity_DNS" {
#  value = "${aws_instance.teamcity.public_dns}"
#}

#output "Teamcity_EC2_IP" {
#  value = "${aws_instance.teamcity.public_ip}"
#}
