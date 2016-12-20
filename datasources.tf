#retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
 most_recent = true
 filter {
   name = "name"
   values = ["${lookup(var.windows_ami_names,var.windows_ver)}"]
    }
 }

data "aws_subnet" "vpc" {
  id = "${var.public_subnets}"
  cidr_block = "${var.public_subnets}"
}

 data "aws_region" "current" {
   current = true
}
