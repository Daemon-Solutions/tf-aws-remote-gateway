## tf-aws-ads

-----

This module is for creating a secure RD gateway solution.

There are some specific requirements when using this module, these are listed below;

    - The certificate name must match the domain name, the domain name must be available in r53 as public hosted zone.
    - The certificate must be in pfx format, stored in a "certs" directory in the terraform directory.
    - Use an s3 resource to upload the the certificate, you can then reference the bucket and object id's when calling the module.
    - Manually create an SSM parameter of a secure string, this secure string should contain the password for the pfx file, you can then pass the name of this 
      SSM parameter into the rdgw module.

-----

### Usage

-----

Declare a module in your Terraform file, for example:

## module for RD Gateway

module "rdgw" {
  source = "../modules/tf-aws-remote-gateway"

  customer = "${var.customer}"
  envtype  = "${var.envtype}"
  envname  = "${var.envname}"

  domain_name           = "${var.domain_name}"
  domain_password       = "${var.domain_password}"
  local_password        = "${var.local_password}"
  public_subnets        = "${module.vpc.public_subnets}"
  ads_dns               = ["${module.ads.ads_dns}"]
  ads_sg                = "${module.ads.ads_sg_id}"
  key_name              = "${var.key_name}"
  ad_type               = "${var.ad_type}"
  route53_zone_id       = "${aws_route53_zone.domain.id}"
  certificate_bucket_id = "${aws_s3_bucket.certificate_bucket.id}"
  certificate_object_id = "${aws_s3_bucket_object.certificate.id}"
  ssm_param_value       = "${var.ssm_param_value}"
}

### Required Variables

  customer = "name of customer"
  envtype  = "name of environment type"
  envname  = "name of environment"

  domain_name           = "name of ads domain"
  domain_password       = "domain password for joining domain"
  local_password        = "local password for rdgw instances"
  public_subnets        = "public subnets for rdgw instances"
  ads_dns               = ["list of ads dns servers"]
  ads_sg                = "id of ads security group"
  key_name              = "keypair name"
  ad_type               = "type of ads MicrosoftAD or SimpleAD"
  route53_zone_id       = "r53 zone id of the domain"
  certificate_bucket_id = "bucket id where cert is stored"
  certificate_object_id = "id of cert object in s3 bucket"
  ssm_param_value       = "name of ssm parameter where encrypted cert password is stored"

### Optional Variables

  aws_region            = "defaults to eu-west-1"
  profile               = "instance profile name - defaults to rdgw"
  rdgw_ssh_cidrs        = "list of allowed rdgw cidr blocks - defaults to ["88.97.72.136/32", "54.76.122.23/32", "195.102.251.16/28", "195.8.68.130/32"]"
  instance_type         = "defaults to t2.medium"
  

### Outputs

  rdgw_iam_profile_id   = "id of the rdgw instance profile"
  launch_config_id"     = "id of launch config"
  asg_id                = "id of asg"
  asg_name              = "name of asg"
  rdgw_external_sg_id   = "id of rdgw sg"
}


