## retrieve vpc id and vpc cidr from subnet

data "aws_subnet" "vpc" {
  id = "${element(var.public_subnets,0)}"
}

## retrieve current region

data "aws_region" "current" {
 current = true
}

## retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
 most_recent = true
 filter {
   name = "name"
   values = ["${lookup(var.windows_ami_names,var.windows_ver)}"]
    }
 }
