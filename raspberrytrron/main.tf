# Raspberry TRRON testing by Gary Mc Dermott

resource "null_resource" "raspberry_pi_bootstrap" {
  count = "${length(var.raspberrypi_ip)}"

  connection {
    type = "ssh"
    user = "${var.username}"
    password = "${var.password}"
    host = "${var.raspberrypi_ip}"
    #host = "${element(var.raspberrypi_ip.*.id, count.index)}"
    timeout     = "10s"
  }

  provisioner "remote-exec" {
    inline = [

      # DATE TIME CONFIG
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",

      # SYSTEM AND PACKAGE UPDATES
      "sudo apt-get update -y"
    ]
  }
}
