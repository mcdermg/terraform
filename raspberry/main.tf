# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html

#

resource "null_resource" "raspberry_pi_bootstrap" {
  connection {
    type     = "ssh"
    user     = "${var.username}"
    password = "${var.password}"
    host     = "${var.raspberrypi_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      # SET HOSTNAME
      "sudo hostnamectl set-hostname ${var.new_hostname}",

      "echo '127.0.1.1 ${var.new_hostname}' | sudo tee -a /etc/hosts",

      # DATE TIME CONFIG
      "sudo timedatectl set-timezone ${var.timezone}",

      "sudo timedatectl set-ntp true",

      # SYSTEM AND PACKAGE UPDATES
      "sudo apt-get update -y",

      # NETWORKING - SET STATIC IP
      "echo 'interface eth0\nstatic ip_address=${var.static_ip_and_mask}\nstatic routers=${var.static_router}\nstatic domain_name_servers=${var.static_dns}' | cat >> /etc/dhcpcd.conf",
    ]

    # REBOOT
    # "sudo shutdown -r 30",

    #upgrades & changes dependencies
    #"sudo apt-get dist-upgrade -y",

    #"sudo reboot"
  }

  provisioner "remote-exec" {
    inline = ["echo 'hello world!'"]

    connection {
      type     = "ssh"
      user     = "${var.username}"
      password = "${var.password}"
      host     = "${var.raspberrypi_ip}"
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook /home/mcdermg/repos/ansiblePi/keyless.yml -u pi"
  }

  provisioner "remote-exec" {
    inline = [
      # CHANGE DEFAULT PASSWORD
      "echo 'pi:${var.new_password}' | sudo chpasswd",
    ]
  }
}
