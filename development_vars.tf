variable "access_key" {}
variable "secret_key" {}
variable "main_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "main_vpc_public_subnet_cidr"{
  default = "10.0.0.0/24"
}

variable "region" {
  default = "us-west-2"
}

#let's role with ubuntu
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-66ca1419"
    "us-west-2" = "ami-51537029"
  }
}
