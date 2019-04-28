resource "null_resource" "raspberry_pi_db" {
  connection {
    type = "ssh"
    user = "pi"
    password = "chefVancouver866"
    host = "192.168.0.38"
  }

  provisioner "remote-exec" {
    inline = [
      # SETUP MySQL DB
      "sudo apt-get install mariadb-server -y"
    ]
  }
}
