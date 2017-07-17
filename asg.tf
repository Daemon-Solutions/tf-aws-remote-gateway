resource "aws_autoscaling_group" "asg" {
  name                = "${var.name}-${var.profile}"
  vpc_zone_identifier = ["${var.subnets}"]

  launch_configuration = "${aws_launch_configuration.lc.name}"

  min_size = "${var.min}"
  max_size = "${var.max}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  tag {
    key = "Name"

    value = "${var.name}-${var.profile}"

    propagate_at_launch = true
  }

  tag {
    key = "EnvironmentName"

    value = "${var.envname}"

    propagate_at_launch = true
  }

  tag {
    key = "EnvironmentType"

    value = "${var.envtype}"

    propagate_at_launch = true
  }

  tag {
    key = "Profile"

    value = "${var.profile}"

    propagate_at_launch = true
  }

  tag {
    key = "Patch Group"

    value = "${var.patch_group}"

    propagate_at_launch = true
  }
}
