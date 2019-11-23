variable "availability_zones" {
  description = "List of availability zones over which to distribute subnets"
  type        = "list"
}

variable "public_cidr_block" {
  default = "10.0.0.0/24"
}
