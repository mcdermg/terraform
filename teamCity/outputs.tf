#Display outputs. Also saving these to file via local-exec in main.tf

output "Teamcity_Public_IP" {
  value = "${aws_eip.teamcity_eip.public_ip}"
}

output "Insance_Name_ID" {
  value = "Teamcity-${random_pet.name.id}"
}

output "Key_Name" {
  value = "${var.key_name}"
}

#output "Teamcity_DNS" {
#  value = "${aws_instance.teamcity.public_dns}"
#}


#output "Teamcity_EC2_IP" {
#  value = "${aws_instance.teamcity.public_ip}"
#}

