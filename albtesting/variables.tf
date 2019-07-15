variable "profile" {
  default = "terraform"
}

variable "region" {
  default = "ca-central-1"
}

variable "ami" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}

variable "environment" {
  default = "dev"
}

variable "vpc_id" {
  default = "vpc-9d1126f4"
}
