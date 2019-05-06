variable "profile" {}

variable "region" {
  default = "eu-west-1"
}

variable "local_IP" {}

variable "wordpress-images" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-0d15e9870fe29bd8e"
    "ca-central-1" = "ami-032c91fb91c423e1f"
  }
}

variable "zones" {
  type = "map"

  default = {
    "eu-west-1"    = "eu-west-1b"
    "ca-central-1" = "ca-central-1a"
  }
}

variable "Tag_Name" {}

variable "Tag_Stage" {}

variable "Tag_Owner" {}

variable "user_data" {}
