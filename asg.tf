## Elastic IP
resource "aws_eip" "rdgw_eip" {
  count = "${length(var.azs)}"
  vpc   = "true"
}

## Userdata Configuration

data "template_file" "rdgw_userdata" {

  template = "${file("${path.module}/include/userdata.tmpl")}"

  vars {

    region          = "${data.aws_region.current.current}"
    dns_servers     = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    local_password  = "${var.local_password}"
    domain_password = "${var.domain_password}"
    domain_name     = "${var.domain_name}"
  }
}


## Launch Configuration
resource "aws_launch_configuration" "lc" {

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = ["${aws_security_group.rdgw_external.id}","${aws_security_group.rdgw_internal.id}","${var.ads_sg}"]
  image_id                    = "${data.aws_ami.windows.id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.rdgw_instance_profile.id}"
  key_name                    = "${var.key_name}"
  user_data                   = "<powershell>${data.template_file.rdgw_userdata.rendered}</powershell><persist>true</persist>"
  associate_public_ip_address = "false"
  enable_monitoring           = "${var.detailed_monitoring}"
}

## Auto-Scaling Group Configuration
resource "aws_sns_topic" "rdgw_asg" {
  name = "${var.customer}-${var.envname}-rdgw"
}

resource "aws_autoscaling_notification" "rdgw_notifications" {
  group_names = [
    "${aws_autoscaling_group.asg.name}"
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
  ]

  topic_arn = "${aws_sns_topic.rdgw_asg.arn}"
}


resource "aws_autoscaling_group" "asg" {
  name                = "${var.customer}-${var.envname}-rdgws-win"
  availability_zones  = ["${var.azs}"]
  vpc_zone_identifier = ["${var.public_subnets}"]

  launch_configuration = "${aws_launch_configuration.lc.name}"

  min_size = "${length(var.azs)}"
  max_size = "${length(var.azs)}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  tag {
    key                 = "Name"
    value               = "${var.customer}-${var.envname}-rdgw-win"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.envname}"
    propagate_at_launch = true
  }

  tag {
    key                 = "EnvType"
    value               = "${var.envtype}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Service"
    value               = "${var.profile}"
    propagate_at_launch = true
  }

  tag {
    key                 = "expected_EIPs"
    value               = "${join(",", aws_eip.rdgw_eip.*.public_ip)}"
    propagate_at_launch = true
  }
}
