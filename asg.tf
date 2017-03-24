## builds rdp jump servers

module "asg" {
  source = "../tf-aws-asg"

  name                  = "${var.service}-${var.envtype}"
  envname               = "${var.envname}"
  service               = "${var.envtype}"

  ami_id                = "${data.aws_ami.windows.id}"
  instance_type         = "${var.instance_type}"
  iam_instance_profile  = "${module.iam_instance_profile.profile_id}"
  key_name              = "${var.key_name}"
  security_groups       = ["${aws_security_group.rdgw_external.id}","${aws_security_group.rdgw_internal.id}","${var.ads_sg}"]
  user_data             = "<powershell>${var.domain_connect_userdata}</powershell><persist>true</persist>"

  subnets               = "${var.public_subnets}"
  availability_zones    = "${var.azs}"
  asg_min               = "${length(var.azs)}"
  asg_max               = "${length(var.azs)}"
}
