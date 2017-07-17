#retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
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

data "template_file" "userdata" {
  template = "${file("${path.module}/include/userdata.tmpl")}"

  vars {
    region                = "${var.aws_region}"
    ad_user               = "${lookup(var.admin_users,var.ad_type)}"
    dns_servers           = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    local_password        = "${var.local_password}"
    domain_password       = "${var.domain_password}"
    domain_name           = "${var.domain_name}"
    route53_zone_id       = "${var.route53_zone_id}"
    certificate_bucket_id = "${var.certificate_bucket_id}"
    certificate_object_id = "${var.certificate_object_id}"
    ssm_param_value       = "${var.ssm_param_value}"
  }
}
