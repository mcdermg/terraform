variable "profile" {
  default     = "terraform"
  description = "AWS cli profile for Terraform to use"
}

variable "AWS_REGION" {
  default     = "eu-west-1"
  description = "Region to be used"
}

variable "port" {
  description = "AWS - The port of the endpoint to be checked"
}

variable "type" {
  description = "AWS - The protocol to use when performing health checks"
}

variable "environment" {
  default     = "dev"
  description = "Tags: Enviroment"
}

variable "owner" {
  default     = "Gary Mc Dermott"
  description = "Tags: Owner"
}
