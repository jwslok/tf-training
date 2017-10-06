#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-faec2e91
#
# Your security group ID is:
#
#     sg-c7eb27ad
#
# Your Identity is:
#
#     asas-starfish
#

terraform {
  backend "atlas" {
    name = "janslok/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-central-1"
}

variable "num_webs" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami           = "ami-5a922335"
  instance_type = "t2.micro"
 
  count                  = "${var.num_webs}"
  subnet_id              = "subnet-faec2e91"
  vpc_security_group_ids = ["sg-c7eb27ad"]

  tags {
    "Identity" = "asas-starfish"
    "Name"     = "web ${count.index+1}/${var.num_webs}"
    "MyTag1"   = "Jan-Willem"
    "MyTag2"   = "Hello"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
SYNTAX ERROR!!!
