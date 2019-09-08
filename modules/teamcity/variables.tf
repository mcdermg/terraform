variable "instance_type" {
  default = "t3.small"
}

variable "key_name" {}

variable "iam_instance_profile" {
  default = "EC2_SSM"
}

variable "user_data" {
  default = <<-EOF
    #! /bin/bash
    sudo yum -y update
    sudo yum -y install git
    sudo yum -y install docker
    sudo usermod -aG docker $USER
    newgrp docker
    source ~/.bash_profile
    sudo systemctl start docker
    sudo systemctl enable docker
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    source ~/.bash_profile
    sudo docker pull jetbrains/teamcity-server
    sudo docker pull jetbrains/teamcity-agent
    sudo docker run --restart always -d --name teamcity-server-instance -p 8080:8111 jetbrains/teamcity-server
  EOF
}

variable "Tag_Stage" {
  default = "Dev"
}

variable "Tag_Owner" {
  default = "Gary Mc Dermott"
}
