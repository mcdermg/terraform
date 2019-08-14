variable "profile" {
  default = "terraform"
}

variable "region" {
  default = "ca-central-1"
}

variable "instance_type" {
  default = "t3.small"
}

variable "key_name" {
  default = "teamcity2"
}

variable "iam_instance_profile" {
  default = "EC2_SSM"
}

variable "user_data" {
  default = ""
}

variable "Tag_Stage" {
  default = "Dev"
}

variable "Tag_Owner" {
  default = "Gary Mc Dermott"
}

variable "local_IP" {
  default     = "181.46.138.37"
  description = "Local workstation IP for ssh access"
}

variable "ssh_user" {
  default = "ec2-user"
}

variable "private_key_path" {}
