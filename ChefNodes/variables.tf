variable "profile" {}
variable "region" {}
variable "amis" {
  type = "map"
  default = {
    "ca-central-1"  = "ami-0427e8367e3770df1"
    "eu-west-1"     = "ami-00035f41c82244dab"
  }
}
variable "instance_type" {}
variable "key_name" {}
#variable "user_data" {}
