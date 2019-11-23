resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "TeamCity Internet Gateway"
  }
}

resource "aws_route_table" "vpc_public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igw.id}"
  }

  tags {
    Name = "TeamCity Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "vpc_public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.vpc_public.id}"
}
