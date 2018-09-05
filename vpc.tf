

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Main VPC Gateway"
    CostAllocation = "AWS Takehome"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "${var.main_vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "Main"
    CostAllocation = "AWS Takehome"
  }
}

resource "aws_subnet" "main_public"{
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.main_vpc_public_subnet_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"


 tags {
   Name = "Main Public Subnet"
   CostAllocation = "AWS Takehome"
 }
}

resource "aws_route" "a_default_route" {
  route_table_id         = "${aws_vpc.main.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
