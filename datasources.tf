#retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
 most_recent = true
 filter {
   name = "name"
   values = ["${lookup(var.windows_ami_names,var.windows_ver)}"]
    }
 }

 data "aws_vpc" "cidr" {
   id = "${data.aws_subnet.vpc.vpc_id}"
 }


data "aws_subnet" "vpc" {
  id = "${element(var.public_subnets,0)}"
}

 data "aws_region" "current" {
   current = true
}

data "aws_route53_zone" "domain" {
  name = "${var.domain_name}"
  #vpc_id = "${data.aws_subnet.vpc.vpc_id}"
}
