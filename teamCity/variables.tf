variable "profile" {
  default = "terraform"
}

variable "region" {
  default = "ca-central-1"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  default = "teamcity2"
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
