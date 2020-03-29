variable "profile" {
  default     = "terraform"
  description = ""
}

variable "region" {
  default     = "eu-west-1"
  description = "Default region to use"
}

variable "ecr_name" {
  default     = "testing"
  description = "default ECR repository name to use"
}
