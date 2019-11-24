resource "aws_subnet" "public" {
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${var.public_cidr_block}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    Name = "Public TeamCity Subnet"
  }
}

resource "aws_subnet" "private" {
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${element(var.private_cidr_block, count.index)}"
  count             = "${length(var.private_cidr_block)}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    Name = "${format("TeamCIty Private Subnet %d", count.index + 1)}"
  }
}

resource "aws_db_subnet_group" "rds" {
  name        = "teamcity-subnet-group"
  description = "TeamCity RDS Subnet Group"
  subnet_ids  = ["${aws_subnet.private.*.id}"]

  tags {
    Name = "TeamCity RDS Subnet Group"
  }
}
