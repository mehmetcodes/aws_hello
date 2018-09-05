resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Main VPC Gateway"
    CostAllocation = "AWS Takehome"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "${var.main_vpc_cidr}"
  tags {
    Name = "Main"
    CostAllocation = "AWS Takehome"
  }
}

resource "aws_subnet" "main_public"{
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.main_vpc_public_subnet_cidr}"

 tags {
   Name = "Main Public Subnet"
   CostAllocation = "AWS Takehome"
 }
}
