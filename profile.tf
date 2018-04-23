module "iam_instance_profile" {
  source = "../tf-aws-iam-instance-profile"

  name           = "${var.customer}-${var.service}"
  ec2_describe   = "1"
  ec2_attach     = "1"
  r53_update     = "1"
  ssm_managed    = "1"
  ec2_write_tags = "1"
}
