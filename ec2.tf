resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main_public.id}"
  depends_on = ["aws_internet_gateway.gw"]
  tags {
    Name = "main"
    CostAllocation = "AWS Takehome"
  }
}

resource "aws_instance" "bastion" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main_public.id}"
  depends_on = ["aws_internet_gateway.gw"]
  tags {
    Name = "main"
    CostAllocation = "AWS Takehome"
  }
}


resource "aws_eip" "example" {
  instance = "${aws_instance.example.id}"
  depends_on = ["aws_internet_gateway.gw"]
  vpc      = true
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  depends_on = ["aws_internet_gateway.gw"]
  vpc      = true

}
