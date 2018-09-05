resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}

resource "aws_instance" "bastion" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}
