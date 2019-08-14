variable "profile" {
  default = "terraform"
}

variable "region" {
  default = "ca-central-1"
}

variable "teamcity-images" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-0c5c15d56ae86fb8f"
    "ca-central-1" = "ami-0d4ae09ec9361d8ac"
  }
}

variable "zones" {
  type = "map"

  default = {
    "eu-west-1"    = "eu-west-1b"
    "ca-central-1" = "ca-central-1a"
  }
}

variable "Tag_Name" {
  default = "Teamcity"
}

variable "Tag_Owner" {
  default = "Gary Mc Dermott"
}

variable "user_data" {}

variable "private_key_path" {}

variable "ssh_user" {
  default = "ec2-user"
}

variable "local_IP" {
  default = "181.46.138.37"
}
