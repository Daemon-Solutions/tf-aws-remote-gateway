

module "iam_instance_profile" {
  source = "../bashton-windows/aws/terraform/localmodules/tf-aws-iam-instance-profile"

  name         = "${var.customer}"
  ec2_describe = "1"
  ec2_attach   = "1"
  s3_readonly  = "1"
  r53_update   = "1"
  ssm_managed  = "1"
}
