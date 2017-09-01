tf-aws-remote-gateway
========================

This module is for creating a secure RD gateway solution.

Usage
-----

Declare a module in your Terraform file, for example:

## module for RD Gateway

```js
module "rdgw" {
  source  = "../modules/tf-aws-remote-gateway"
  name    = "remote-gateway"
  envname = "${var.envname}"

  ad_domain_name     = "${var.domain_name}"
  ad_domain_password = "${var.domain_password}"
  local_password     = "${var.local_password}"
  ads_dns              = ["${module.ads.ads_dns}"]
  security_groups      = ["${module.ads.ads_sg_id}"]
  key_name             = "${var.key_name}"
  ad_type              = "${var.ad_type}"
  aws_region           = "${var.aws_region}"
  public_r53_domain    = "${data.aws_route53_zone.public_domain.name}"
  public_r53_domain_id = "${data.aws_route53_zone.public_domain.id}"
  patch_group          = "automatic"
  path_to_cert         = "../certs/team-bowser.com.pfx"
  certificate_password = "pleasehelp"
  allowed_remote_cidrs = ["${data.terraform_remote_state.vpc.allowed_remote_cidrs}"]
  subnets              = "${data.terraform_remote_state.vpc.public_subnets}"
  min                  = "${length(data.terraform_remote_state.vpc.public_subnets)}"
  max                  = "${length(data.terraform_remote_state.vpc.public_subnets)}"
  user_data            = "${data.template_file.puppet.rendered}"
}
```

Variables
---------

- `customer` - name of customer
- `envtype`  - name of environment type
- `envname`  - name of environment

- `domain_name`           - name of ads domain
- `domain_password`       - domain password for joining domain
- `local_password`        - local password for rdgw instances
- `public_subnets`        - public subnets for rdgw instances
- `ads_dns`               - [list of ads dns servers]
- `ads_sg`                - id of ads security group
- `key_name`              - keypair name
- `ad_type`               - type of ads MicrosoftAD or SimpleAD
- `route53_zone_id`       - r53 zone id of the domain
- `certificate_bucket_id` - bucket id where cert is stored
- `certificate_object_id` - id of cert object in s3 bucket
- `ssm_param_value`       - name of ssm parameter where encrypted cert password is stored

Optional Variables
------------------

- `aws_region`            - defaults to eu-west-1
- `profile`               - instance profile name defaults to rdgw
- `rdgw_ssh_cidrs`        - list of allowed rdgw cidr blocks defaults to

`["88.97.72.136/32", "54.76.122.23/32", "195.102.251.16/28", "195.8.68.130/32"]`

- `instance_type`         - defaults to t2.medium


Outputs
-------

- `rdgw_iam_profile_id` - id of the rdgw instance profile
- `launch_config_id`    - id of launch config
- `asg_id`              - id of asg
- `asg_name`            - name of asg
- `rdgw_external_sg_id` - id of rdgw sg
