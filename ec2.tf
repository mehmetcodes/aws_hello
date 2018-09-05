resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main_public.id}"
  key_name = "deployer-key"
  user_data = "${file("user-data.example")}"
  vpc_security_group_ids = ["${aws_security_group.main_vpc_web.id}","${aws_security_group.main_vpc_ssh.id}"]
  depends_on = ["aws_internet_gateway.gw"]
  tags {
    Name = "main vpc example"
    CostAllocation = "AWS Takehome"
  }
}


resource "aws_volume_attachment" "example" {
  device_name = "/dev/sdf"
  volume_id = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.example.id}"
}


resource "aws_ebs_volume" "example" {
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    size = 1

    tags {
        Name = "HelloWorld Volume"
    }
}

resource "aws_instance" "bastion" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main_public.id}"
  key_name = "deployer-key"
  depends_on = ["aws_internet_gateway.gw"]
  vpc_security_group_ids = ["${aws_security_group.main_allow_ssh.id}"]
  tags {
    Name = "main vpc bastion"
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
