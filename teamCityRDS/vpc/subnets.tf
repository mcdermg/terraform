resource "aws_subnet" "public" {
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${var.public_cidr_block}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    Name = "Public TeamCity Subnet"
  }
}
