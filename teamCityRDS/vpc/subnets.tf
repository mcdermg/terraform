variable "public_cidr_block" {
  default = "10.0.0.0/24"
}

variable "availability_zones" {
  description = "List of availability zones over which to distribute subnets"
  type        = "list"
}

resource "aws_subnet" "public" {
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${var.public_cidr_block}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    Name = "Public TeamCity Subnet"
  }
}
