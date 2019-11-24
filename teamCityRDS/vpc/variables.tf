variable "public_cidr_block" {
  description = "subnets.tf aws_subnet public"
  default     = "10.0.0.0/24"
}

variable "availability_zones" {
  description = "subnets.tf - public & private subnet resource - List of availability zones over which to distribute subnets"
  type        = "list"
}

variable "length" {
  default     = 1
  description = "routing.tf - aws_route_table_association vpc_private"
}

variable "private_cidr_block" {
  description = "routing.tf - aws_route_table_association vpc_private"
  type        = "list"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
