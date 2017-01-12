

data "template_file" "rdgw_userdata" {

  template = "${file("${path.module}/include/userdata.tmpl")}"

  vars {

    region          = "${data.aws_region.current.name}"
    ad_user         = "${var.ad_user}"
    dns_servers     = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    local_password  = "${var.local_password}"
    domain_password = "${var.domain_password}"
    domain_name     = "${var.domain_name}"
  }
}

module "asg" {
  source = "../tf-aws-asg"

  name                  = "${var.customer}"
  envname               = "${var.envname}"
  service               = "${var.envtype}"

  ami_id                = "${data.aws_ami.windows.id}"
  instance_type         = "${var.instance_type}"
  iam_instance_profile  = "${module.iam_instance_profile.profile_id}"
  key_name              = "${var.key_name}"
  security_groups       = ["${aws_security_group.rdgw_internal.id}","${var.ads_sg}"]
  user_data             = "<powershell>${data.template_file.rdgw_userdata.rendered}</powershell><persist>true</persist>"

  subnets               = "${var.public_subnets}"
  availability_zones    = "${var.azs}"
  asg_min               = "${length(var.azs)}"
  asg_max               = "${length(var.azs)}"
}

// Route53 Record
resource "aws_route53_record" "elb" {
  count = "1"
  zone_id = "${var.route53_zone_id}"
  name = "${var.service}.${var.route53_zone_name}"
  type = "A"

  alias {
    name = "${aws_elb.elb.dns_name}"
    zone_id = "${var.route53_zone_id}"
    evaluate_target_health = false
  }
}

// S3 Bucket For Logs
resource "aws_s3_bucket" "elb_log_bucket" {
  bucket = "${var.customer}-${var.envname}-${var.service}-bucket"
  force_destroy = true
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSELBS3Logging",
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Principal": { "AWS": "arn:aws:iam::${lookup(var.elb_aws_account, data.aws_region.current.name)}:root" },
      "Resource": "arn:aws:s3:::${var.customer}-${var.envname}-${var.service}-bucket/*"
    }
  ]
}
POLICY

  tags {
    Name        = "${var.customer}"
    Environment = "${var.envname}"
    Service     = "${var.service}"
    Envtype     = "${var.envtype}"
  }
}

// ELB Configuration
resource "aws_elb" "elb" {
  name = "${var.customer}-${var.envname}-${var.service}-elb"
  subnets = ["${var.public_subnets}"]
  security_groups = ["${aws_security_group.rdgw_external.id}"]

  access_logs {
    bucket = "${aws_s3_bucket.elb_log_bucket.id}"
    bucket_prefix = "ELB"
    interval = "60"
  }

  listener {
    instance_port = "80"
    instance_protocol = "tcp"
    lb_port = "80"
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = "true"
  idle_timeout = "60"
  internal = "false"

  tags = {
    Name        = "${var.customer}"
    Environment = "${var.envname}"
    Service     = "${var.service}"
    Envtype     = "${var.envtype}"
  }
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = "${module.asg.asg_id}"
  elb                    = "${aws_elb.elb.id}"
}
