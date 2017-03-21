## builds rdp jump servers

module "asg" {
  source = "../tf-aws-asg"

  name    = "${var.customer}-${var.service}"
  envname = "${var.envname}"
  service = "${var.envtype}"

  ami_id               = "${data.aws_ami.windows.id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${module.iam_instance_profile.profile_id}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.rdgw_external.id}", "${var.ads_sg}"]
  user_data            = "<powershell>${data.template_file.rdgw_userdata.rendered}</powershell><persist>true</persist>"
  subnets              = "${var.public_subnets}"
  min                  = "${length(var.subnets)}"
  max                  = "${length(var.subnets)}"
}
