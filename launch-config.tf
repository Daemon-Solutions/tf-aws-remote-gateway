// Launch Configuration
resource "aws_launch_configuration" "lc" {
  lifecycle {
    create_before_destroy = true
  }

  name_prefix                 = "${var.envname}-${var.profile}"
  security_groups             = ["${aws_security_group.rdgw.id}", "${var.security_groups}"]
  image_id                    = "${data.aws_ami.windows.id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.instance_profile.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = "${var.detailed_monitoring}"
  user_data                   = "<powershell>${data.template_file.userdata.rendered}${var.user_data}</powershell><persist>true</persist>"
}
