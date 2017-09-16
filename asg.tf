resource "aws_autoscaling_group" "asg" {
  name                = "${local.name_prefix}"
  vpc_zone_identifier = ["${var.subnets}"]

  launch_configuration = "${aws_launch_configuration.lc.name}"

  min_size = "${var.min}"
  max_size = "${var.max}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  tag {
    key = "Name"

    value = "${local.tag_name}"

    propagate_at_launch = true
  }

  tag {
    key = "EnvironmentName"

    value = "${local.tag_environmentname}"

    propagate_at_launch = true
  }

  tag {
    key = "Profile"

    value = "${local.tag_profile}"

    propagate_at_launch = true
  }

  tag {
    key = "Patch Group"

    value = "${var.patch_group}"

    propagate_at_launch = true
  }
}
