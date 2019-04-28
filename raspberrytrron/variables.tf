#variable "raspberrypi_ip" {
variable "raspberrypi_ip" {
description = "List of IP Addresses to use"
type = "list"
default = ["192.168.0.35", "192.168.0.36", "192.168.0.37", "192.168.0.38"]
}
variable "username" {}
variable "password" {}
variable "timezone" {}
